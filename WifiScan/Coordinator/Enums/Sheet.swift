import Foundation

enum Sheet: Identifiable {
    case sheet

    var id: String {
        UUID().uuidString
    }
}
