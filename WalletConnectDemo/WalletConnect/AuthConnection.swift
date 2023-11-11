//
//  AuthConnection.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 11.11.2023.
//

import UIKit
import Auth
import Combine

final class AuthConnection {
    var onWalletAuthorized: ((String) -> Void)?

    private var pairUri: WalletConnectURI?
    private var publishers = Set<AnyCancellable>()

    init() {
        setupObservers()
    }

    deinit {
        publishers.forEach { $0.cancel() }
    }

    // MARK: - Public
    func connect() async throws {
        let params = RequestParams(
            domain: "https://your-best-site.com",
            chainId: "eip155:1",
            nonce: "777",
            aud: "https://your-best-site.com",
            nbf: nil,
            exp: nil,
            statement: "Sign this message to verify your wallet and connect to Surreal.",
            requestId: nil,
            resources: nil
        )

        do {
            let pairUri = try await Pair.instance.create()
            self.pairUri = pairUri
            try await Auth.instance.request(params, topic: pairUri.topic)
        } catch {
            throw error
        }
    }

    func redirectToWallet() async {
        guard let deeplinkUrl = pairUri?.deeplinkUri,
              /*
              here we use rainbow because metamask dosen't support
              auth protocol
               */
              let url = URL(string: "https://rnbwapp.com/wc?uri=\(deeplinkUrl)") else { return }

        await MainActor.run(body: {
            UIApplication.shared.open(url)
        })
    }

    // MAKR: - Private
    private func setupObservers() {
        Auth.instance.authResponsePublisher.sink { [weak self] _, result in
            guard let self else { return }

            Task { @MainActor in
                switch result {
                case .success(let cacao):
                    do {
                        let address = try DIDPKH(did: cacao.p.iss).account.address
                        self.onWalletAuthorized?(address)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .store(in: &publishers)
    }
}
