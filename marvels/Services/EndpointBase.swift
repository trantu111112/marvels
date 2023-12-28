//
//  EndpointBuilder.swift
//  marvels
//
//  Created by Tu Tran on 27/12/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    // Add more methods if needed
}

class EndpointBase {
    var baseUrl: String = Configs.BASE_URL
    var publicKey: String = Configs.PUBLIC_KEY
    var privateKey: String = Configs.PRIVATE_KEY
    var method: HTTPMethod = .get
    var limit: Int = 20
    var offset: Int = 0
    var path: [String] = []
    var queryItems: [URLQueryItem] = []

    init() {
        baseSetup()
    }

    private func baseSetup() {
        let now = String(describing: Date.timeIntervalBetween1970AndReferenceDate)
        let md5 = (now + privateKey + publicKey).md5Hash()
        queryItems = [
            "ts": now,
            "apikey": publicKey,
            "hash": md5,
            "limit": "\(limit)",
            "offset": "\(offset)"
        ].map({URLQueryItem(name: $0.key, value: $0.value)})
    }

    func method(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }

    func limit(_ limit: Int) -> Self {
        self.limit = limit
        if let index = self.queryItems.firstIndex(where: { item in item.name == "limit" }) {
            queryItems[index].value = String(limit)
        }
        return self
    }

    func offset(_ offset: Int) -> Self {
        self.offset = offset
        if let index = self.queryItems.firstIndex(where: { item in item.name == "offset" }) {
            queryItems[index].value = String(offset)
        }
        return self
    }

    func path(_ path: String) -> Self {
        self.path.append(path)
        return self
    }

    func addQueryItem(name: String, value: String?) -> Self {
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        return self
    }

    func build() -> String {
        var components = URLComponents(string: baseUrl)!
        components.path +=  "/" + path.joined(separator: "/")
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        return components.string!
    }

}
