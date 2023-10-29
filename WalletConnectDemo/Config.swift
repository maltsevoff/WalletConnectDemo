//
//  Config.swift
//  WalletConnectDemo
//
//  Created by Aleksandr Maltsev on 29.10.2023.
//

import Foundation

struct Config {
    static func projectId() -> String {
        guard let projectId = config(for: "PROJECT_ID"), projectId.isEmpty == false else {
            fatalError("PROJECT_ID is not set")
        }

        return projectId
    }

    private static func config(for key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
