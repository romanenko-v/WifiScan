import Foundation

struct TodoItem: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    var completed: Bool
}
