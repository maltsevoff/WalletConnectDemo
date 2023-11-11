//
//  AuthViewModel.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 11.11.2023.
//

import Foundation

enum AuthState {
    case disconnected
    case authorized
}

@Observable
final class AuthViewModel {
    var state: AuthState = .disconnected
    var address: String = ""

    private let authConnection = AuthConnection()

    init() {
        authConnection.onWalletAuthorized = { [weak self] address in
            self?.address = address
            self?.state = .authorized
        }
    }

    func authorize() {
        Task {
            do {
                try await authConnection.connect()
                await authConnection.redirectToWallet()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
