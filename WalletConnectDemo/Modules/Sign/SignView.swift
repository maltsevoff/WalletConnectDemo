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
        Text("Connected wallet: \(viewModel.address)")
    }

    private var disconnectedView: some View {
        Button("Connect") {
            viewModel.connect()
        }
    }

    private var signedView: some View {
        Text("Signed")
    }
}

#Preview {
    SignView(viewModel: SignViewModel())
}
