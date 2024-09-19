import SwiftUI

final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var fullScreenCover: FullScreenCover?
    @Published var sheet: Sheet?
    @Published var selectedTab: Tab = .fetcher
    @Published var isShouldShowTabBar = true

    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .todos(let todoItems):
            TodosView(todoItems: todoItems) { [weak self] in
                self?.pop()
            }
        }
    }

    @ViewBuilder
    func build(_ fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .fullScreenCover: Text("build(_ fullScreenCover: FullScreenCover): fullScreenCover")
        }
    }

    @ViewBuilder
    func build(_ sheet: Sheet) -> some View  {
        switch sheet {
        case .sheet: Text("build(_ sheet: Sheet): sheet")
        }
    }
    
    @ViewBuilder
    func build(_ tab: Tab) -> some View {
        switch tab {
        case .fetcher: 
            FetcherView() { [weak self] todoItems in
                self?.push(.todos(todoItems: todoItems))
            }
        }
    }
}

private extension Coordinator {
    func selectTab(_ tab: Tab) {
        selectedTab = tab
    }
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func present(_ fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func present(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    func showTabBar() {
        self.isShouldShowTabBar = true
    }
    
    func hideTabBar() {
        self.isShouldShowTabBar = false
    }

    func dismissSheet() {
        self.sheet = nil
    }
}
