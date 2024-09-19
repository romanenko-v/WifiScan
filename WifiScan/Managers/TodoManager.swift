import Foundation

final class TodoManager {
    func fetchTodos(completion: @escaping (Result<[TodoItem], Error>) -> Void) {
        guard let url = URL(string: Constants.fetchURL) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.InvalidURL])))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.noDataReceived])))
                return
            }

            do {
                let todoItems = try JSONDecoder().decode([TodoItem].self, from: data)
                completion(.success(todoItems))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

// MARK: - Constants
private extension TodoManager {
    enum Constants {
        static let fetchURL: String = "https://jsonplaceholder.typicode.com/todos"
        static let InvalidURL = "Invalid URL"
        static let noDataReceived = "No data received"
    }
}
