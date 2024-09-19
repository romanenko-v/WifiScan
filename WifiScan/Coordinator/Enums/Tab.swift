enum Tab: String, Identifiable, CaseIterable {
    case fetcher

    var id: String { self.rawValue }
}
