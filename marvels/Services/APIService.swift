import Foundation

final class APIClient {
    
    // MARK: - Properties
    
    static let shared = APIClient()
    private let baseURL = "https://gateway.marvel.com"  // Replace with your API base URL
    
    func fetchData<T: Codable>(
        from urlString: String,
        responseType: T.Type,
        headers: [String: String]? = nil,
        queryParameters: [String: String]? = nil
    ) async throws -> T {
        guard let url = URL(string: (baseURL + urlString)) else {
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

    func fetchDataNew<T: Codable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)

        return result
    }

}

// MARK: - Enumerations

enum NetworkError: Error {
    case invalidURL
    case noData
}
