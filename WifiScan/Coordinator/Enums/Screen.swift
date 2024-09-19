import Foundation

enum Screen: Identifiable {
    case todos(todoItems: [TodoItem])

    var id: String {
        UUID().uuidString
    }
}

extension Screen: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

