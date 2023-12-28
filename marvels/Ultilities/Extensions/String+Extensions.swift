//
//  String+Extensions.swift
//  marvels
//
//  Created by Tu Tran on 24/12/2023.
//

import Foundation
import CryptoKit

extension String {
    func md5Hash() -> String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}

extension Optional where Wrapped == String {
    /// Safely unwraps an optional string or returns a default value.
    ///
    /// - Parameter defaultValue: The value to return if the optional is `nil`.
    /// - Returns: The unwrapped string or the default value.
    func unwrapped(or defaultValue: String = "") -> String {
        if let unwrappedValue = self {
            return unwrappedValue
        } else {
            return defaultValue
        }
    }
}
