//
//  Mockable.swift
//  marvelsTests
//
//  Created by Tu Tran on 29/12/2023.
//

import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T {
//        guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            fatalError("Failed to load Json file")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decodeObject = try JSONDecoder().decode(T.self, from: data)
            return decodeObject
        } catch {
            fatalError("Error for decode Json file")
        }
    }
}
