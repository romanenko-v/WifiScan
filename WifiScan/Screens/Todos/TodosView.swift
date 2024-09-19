import SwiftUI

struct TodosView: View {
    @ObservedObject var viewModel = TodosViewModel()
    var todoItems: [TodoItem]
    let backAction: () -> ()
    
    var body: some View {
        NavigationBarView(title: Constants.title,
                          buttonColor: .darkWhite,
                          leadingButton: .back(action: backAction)
        ) {
            BackgroundStack {
                VStack {
                    ScrollView {
                        VStack(spacing: Constants.spacing) {
                            infoContainerView
                            TodosListView(title: String.Todos.notCompleted, todoItems: $viewModel.todoItemsNotCompleted) { todoItem in
                                updateTodoItemsFor(todoItem)
                            }
                            TodosListView(title: String.Todos.completed, todoItems: $viewModel.todoItemsCompleted) { todoItem in
                                updateTodoItemsFor(todoItem)
                            }
                            Spacer()
                        }
                        .padding(.top, Constants.topPadding)
                    }
                    
                    CornerButton(text: String.Todos.done,
                                 isActive: Constants.isActiveButton,
                                 width: Constants.widthButton) {
                        backAction()
                    }
                }
            }
            .onAppear {
                viewModel.setTodoItems(todoItems)
            }
        }
    }
}

private extension TodosView {
    var infoContainerView: some View {
        BackgroundContainer(opacity: Constants.backgroundOpacity) {
            HStack(spacing: Constants.labelSpacing) {
                Image(systemName: String.Icon.handTap)
                    .font(.system(size: Constants.imageSystemSize))
                    .foregroundColor(.lightGray)
                    .rotationEffect(Constants.rotationDegrees)
                Text(String.Todos.tapOnTheTodo)
                    .ibmPlexSans(.semiBold, size: Constants.textSize)
                    .foregroundColor(.lightGray)
                Spacer()
            }
        }
    }
    
    func updateTodoItemsFor(_ todoItem: TodoItem) {
        withAnimation {
            viewModel.updateCompletedStatusFor(todoItem)
        }
    }
}

// MARK: - Constants
private extension TodosView {
    enum Constants {
        static let title: String = String.Todos.title
        static let widthButton: CGFloat = 343
        static let isActiveButton: Bool = true
        static let backgroundOpacity: Double = 0.6
        static let rotationDegrees: Angle = .degrees(15)
        static let textSize: CGFloat = 14
        static let imageSystemSize: CGFloat = 24
        static let labelSpacing: CGFloat = 10
        static let topPadding: CGFloat = 46
        static let spacing: CGFloat = 24
    }
}
