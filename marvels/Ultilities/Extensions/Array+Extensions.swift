//
//  Array+Extension.swift
//  marvels
//
//  Created by Tu Tran on 24/12/2023.
//

import Foundation

extension Array {
    /// Safely unwraps an optional array or returns a default value.
    ///
    /// - Parameter defaultValue: The value to return if the array is empty.
    /// - Returns: The unwrapped array or the default value.
    func unwrapped(or defaultValue: [Element] = []) -> [Element] {
        if !isEmpty {
            return self
        } else {
            return defaultValue
        }
    }
}
