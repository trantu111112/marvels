import Foundation

protocol APIClientProtocol {
    static var shared: APIClientProtocol {get}
    func fetchDataNew<T: Codable>(endpoint: String) async throws -> T
}

final class APIClient: APIClientProtocol {
    // MARK: - Properties
    static let shared: APIClientProtocol = APIClient()
    var session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func fetchDataNew<T: Codable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)

        return result
    }

}
