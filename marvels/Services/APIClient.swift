import Foundation

enum MarvelAPIEndpoint {
    case characters
    case character(characterId: String)
    case comics
    case comic(comicId: String)

    var path: String {
        switch self {
        case .characters:
            return "/characters"
        case .character(let characterId):
            return "/characters/\(characterId)"
        case .comics:
            return "/comics"
        case .comic(let comicId):
            return "/comics/\(comicId)"
        }
    }
}

class EndpointBuilder {
    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func build(for endpoint: MarvelAPIEndpoint) -> String {
        return baseUrl + endpoint.path
    }
}

class APIClientNew {
    private let endpointBuilder: EndpointBuilder
    private let baseURL: String

    init(baseURL: String) {
        self.endpointBuilder = EndpointBuilder(baseUrl: baseURL)
        self.baseURL = baseURL
    }

    func fetchData<T: Codable>(
        from endpoint: MarvelAPIEndpoint,
        responseType: T.Type,
        headers: [String: String]? = nil,
        queryParameters: [String: String]? = nil
    ) async throws -> T {
        let urlString = endpointBuilder.build(for: endpoint)
        return try await fetchData(from: urlString, responseType: responseType, headers: headers, queryParameters: queryParameters)
    }

    func fetchData<T: Codable>(
        from urlString: String,
        responseType: T.Type,
        headers: [String: String]? = nil,
        queryParameters: [String: String]? = nil
    ) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }

        var request = URLRequest(url: components?.url ?? url)
        request.httpMethod = "GET"

        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let result = try decoder.decode(responseType, from: data)

        return result
    }
}

