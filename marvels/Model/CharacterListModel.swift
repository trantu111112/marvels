//
//  ModelProducListModel.swift?
//  marvels?
//
//  Created by Tu Tran on 24/12/2023.
//

import Foundation

struct MarvelResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: MarvelData?
}

struct MarvelData: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [MarvelCharacter]?
}

struct MarvelCharacter: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: MarvelThumbnail?
    let resourceURI: String?
    let comics: MarvelCollection?
    let series: MarvelCollection?
    let stories: MarvelCollection?
    let events: MarvelCollection?
    let urls: [MarvelURL]?
}

struct MarvelThumbnail: Codable {
    var path: String?
    var `extension`: String?

    mutating func getFullPath() -> String {
        return path.unwrapped() + `extension`.unwrapped()
    }
}

struct MarvelCollection: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [MarvelItem]?
    let returned: Int?
}

struct MarvelItem: Codable {
    let resourceURI: String?
    let name: String?
}

struct MarvelURL: Codable {
    let type: String?
    let url: String?

    mutating func getFullPath() -> String {
        return url.unwrapped() + type.unwrapped()
    }
}

extension Optional where Wrapped == MarvelThumbnail {
    var safelyUnwrapped: MarvelThumbnail {
        return self ?? MarvelThumbnail(path: nil, extension: nil)
    }
}

extension Optional where Wrapped == MarvelCollection {
    var safelyUnwrapped: MarvelCollection {
        return self ?? MarvelCollection(available: nil, collectionURI: nil, items: nil, returned: nil)
    }
}

extension Optional where Wrapped == MarvelItem {
    var safelyUnwrapped: MarvelItem {
        return self ?? MarvelItem(resourceURI: nil, name: nil)
    }
}

extension Optional where Wrapped == MarvelURL {
    var safelyUnwrapped: MarvelURL {
        return self ?? MarvelURL(type: nil, url: nil)
    }
}
