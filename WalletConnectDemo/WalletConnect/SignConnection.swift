//
//  SignConnection.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 29.10.2023.
//

import SwiftUI
import WalletConnectSign
import Combine

class SignConnection {

    var onConnect: ((String) -> Void)?
    var onSign: (() -> Void)?

    private var cancellables = Set<AnyCancellable>()
    private var sessionTopic: String?
    private var address: String?
    private var pairUri: WalletConnectURI?

    // MARK: - Init
    init() {
        setupObservers()
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }

    // MARK: - Public
    func connect() async throws {
        let requiredNamespaces: [String: ProposalNamespace] = [
            "eip155": ProposalNamespace(
                chains: [
                    Blockchain("eip155:1")!
                ],
                methods: [
                    "personal_sign"
                ], events: []
            )
        ]

        do {
            let pairUri = try await Pair.instance.create()
            self.pairUri = pairUri
            try await Sign.instance.connect(requiredNamespaces: requiredNamespaces,
                                            // metamask doesn't handle a request without these dummy values
                                            optionalNamespaces: [:],
                                            sessionProperties: ["key": "value"],
                                            topic: pairUri.topic)
        } catch {
            throw error
        }
    }

    func sign() async {
        guard let chain = Blockchain("eip155:1"),
              let address, // previously saved
              let topic = sessionTopic else { return } // previously saved

        let method = "personal_sign"
        let requestParams = AnyCodable(["Verefication message", address])
        let request = Request(topic: topic,
                              method: method,
                              params: requestParams,
                              chainId: chain)

        try? await Sign.instance.request(params: request)
    }

    func redirectToWallet() async {
        guard let deeplinkUrl = pairUri?.deeplinkUri,
              let url = URL(string: "metamask://wc?uri=\(deeplinkUrl)") else { return }

        await MainActor.run(body: {
            UIApplication.shared.open(url)
        })
    }

    // MARK: - Private
    private func setupObservers() {
        Sign.instance.sessionSettlePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] session in
                if let account = session.accounts.first {
                    self?.sessionTopic = session.topic
                    self?.address = account.address
                    self?.onConnect?(account.address)
                }
            }
            .store(in: &cancellables)

        Sign.instance.sessionResponsePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in

            }
            .store(in: &cancellables)
    }
}
