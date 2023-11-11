//
//  AuthView.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 11.11.2023.
//

import SwiftUI

struct AuthView: View {
    let viewModel: AuthViewModel

    var body: some View {
        switch viewModel.state {
        case .disconnected:
            disconnectedView
        case .authorized:
            authorizedView
        }
    }

    private var disconnectedView: some View {
        Button("Auth") {
            viewModel.authorize()
        }
        .buttonStyle(.borderedProminent)
    }

    private var authorizedView: some View {
        VStack(spacing: 16) {
            Text("Authorized")
                .font(.title)

            Text("\(viewModel.address)")
        }
    }
}

#Preview {
    AuthView(viewModel: .init())
}
