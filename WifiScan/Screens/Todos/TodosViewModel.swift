import Foundation

final class TodosViewModel: ObservableObject {
    @Published var todoItemsCompleted: [TodoItem] = []
    @Published var todoItemsNotCompleted: [TodoItem] = []
    
    func setTodoItems(_ todoItems: [TodoItem]) {
        todoItemsCompleted = todoItems.filter { $0.completed }
        todoItemsNotCompleted = todoItems.filter { !$0.completed }
    }
    
    func updateCompletedStatusFor(_ todoItem: TodoItem) {
        var updatedTodoItem = todoItem
        updatedTodoItem.completed = !updatedTodoItem.completed
        
        if todoItem.completed {
            todoItemsCompleted.removeAll { $0.id == updatedTodoItem.id }
            todoItemsNotCompleted.append(updatedTodoItem)
        } else {
            todoItemsNotCompleted.removeAll { $0.id == updatedTodoItem.id }
            todoItemsCompleted.append(updatedTodoItem)
        }
    }
}
