//
//  ContentView.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 29.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SignView(viewModel: .init())
                .tabItem {
                    Label("Sign", systemImage: "signature")
                }
            AuthView(viewModel: .init())
                .tabItem {
                    Label("Auth", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}
