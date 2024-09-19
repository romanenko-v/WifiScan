import Foundation

final class FetcherViewModel: ObservableObject {
    @Published var fetchStatus: FetchStatus = .initial
    @Published var isActiveButton: Bool = false
    @Published var isToggled: Bool = true
    @Published var TodoItems: [TodoItem] = []
    
    private var todoManager: TodoManager = TodoManager()
    
    func onAppear() {
        fetchStatus = .initial
        isActiveButton = fetchStatus == .finish
    }
    
    func onChangeFetchStatus(_ newFetchStatus: FetchStatus) {
        isActiveButton = fetchStatus == .finish
    }
    
    func startFetching() {
        fetchStatus = .fetching
        todoManager.fetchTodos { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let todoItems):
                    self.saveTodo(todoItems)
                case .failure(let error):
                    print("--FetcherViewModel.startFetching() ERROR: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func saveTodo(_ todoItems: [TodoItem]) {
        fetchStatus = .finish
        TodoItems = todoItems
        if !isToggled {
            TodoItems = todoItems.filter { $0.userId == Constants.todoUserIdFilter }
        }
    }
}

// MARK: - Constants
private extension FetcherViewModel {
    enum Constants {
        static let todoUserIdFilter: Int = 5
    }
}
