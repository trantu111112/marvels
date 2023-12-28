import Foundation

final class APIClient {

    // MARK: - Properties
    static let shared = APIClient()
    func fetchDataNew<T: Codable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)

        return result
    }

}

// MARK: - Enumerations
//
// enum NetworkError: Error {
//    case invalidURL
//    case noData
// }
