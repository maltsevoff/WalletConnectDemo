//
//  WalletConnectDemoApp.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 29.10.2023.
//

import SwiftUI

@main
struct WalletConnectDemoApp: App {

    init() {
        WalletConnectManager.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
