//
//  Eviroment.swift
//  marvels
//
//  Created by Tu Tran on 27/12/2023.
//

import Foundation

enum Configs {
    private static let dict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist is not found")
        }
        return dict
    }()
    static let BASE_URL: String = {
        guard let baseString = Configs.dict["BASE_URL"] as? String else {
            fatalError("Base url is not found")
        }
        let base_url = baseString.replacingOccurrences(of: "\\", with: "")
        return base_url
    }()
    static let PUBLIC_KEY: String = {
        guard let publicKey = Configs.dict["PUBLIC_KEY"] as? String else {
            fatalError("Base url is not found")
        }
        return publicKey
    }()
    static let PRIVATE_KEY: String = {
        guard let privateKey = Configs.dict["PRIVATE_KEY"] as? String else {
            fatalError("Base url is not found")
        }
        return privateKey
    }()
}
