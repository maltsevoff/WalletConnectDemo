//
//  WalletConnectManager.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 29.10.2023.
//

import Foundation
import WalletConnectNetworking
import WalletConnectPairing
import Auth

class WalletConnectManager {
    static func configure() {
        Networking.configure(projectId: Config.projectId, socketFactory: DefaultSocketFactory())
        Auth.configure(crypto: DefaultCryptoProvider())

        let metadata = AppMetadata(
            name: "WalletConnectDemo",
            description: "WalletConnectDemo",
            url: "https://walletconnect.org",
            icons: []
        )

        Pair.configure(metadata: metadata)
    }
}
