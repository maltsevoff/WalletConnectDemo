//
//  SignViewModel.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 29.10.2023.
//

import SwiftUI

enum SignState {
    case disconnected
    case connected
    case signed
}

@Observable final class SignViewModel {

    var state: SignState = .disconnected
    var address: String = ""

    @ObservationIgnored private var signConnection = SignConnection()

    init() {
        signConnection.onConnect = { [weak self] address in
            self?.address = address
            self?.state = .connected
        }
        signConnection.onSign = { [weak self] in
            self?.state = .signed
        }
    }

    func connect() {
        Task {
            do {
                try await signConnection.connect()
                await signConnection.redirectToWallet()
            } catch {

            }
        }
    }

    func sign() {
        Task {
            await signConnection.sign()
        }
    }
}
