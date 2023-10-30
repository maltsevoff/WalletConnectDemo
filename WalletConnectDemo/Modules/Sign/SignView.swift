//
//  SignView.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 29.10.2023.
//

import SwiftUI

struct SignView: View {
    let viewModel: SignViewModel

    var body: some View {
        switch viewModel.state {
        case .disconnected:
            disconnectedView
        case .connected:
            connectedView
        case .signed:
            signedView
        }
    }

    private var connectedView: some View {
        VStack(spacing: 16) {
            Text("Connected")
                .font(.title)

            Text("\(viewModel.address)")

            Button("Sign") {
                viewModel.sign()
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var disconnectedView: some View {
        Button("Connect wallet") {
            viewModel.connect()
        }
        .buttonStyle(.borderedProminent)
    }

    private var signedView: some View {
        VStack(spacing: 16) {
            Text("Connected & Signed")
                .font(.title)

            Text("\(viewModel.address)")
        }
    }
}

#Preview {
    let viewModel = SignViewModel()
    viewModel.state = .disconnected
    return SignView(viewModel: viewModel)
}
