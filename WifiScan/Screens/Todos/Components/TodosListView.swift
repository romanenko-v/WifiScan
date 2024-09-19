import SwiftUI

struct TodosListView: View {
    let title: String
    @Binding var todoItems: [TodoItem]
    let tapItem: (_ todoItem: TodoItem) -> ()
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .ibmPlexSans(.semiBold, size: 15)
                    .foregroundColor(.lightGray.opacity(0.6))
                    .padding(.leading)
                Divider()
                    .frame(height: 5)
                    .background(.darkGray.opacity(0.65))
                Spacer()
            }
            Divider()
                .frame(height: 1)
                .background(Color.darkGray.opacity(0.65))
                .padding(.horizontal)
            ForEach(todoItems, id: \.id) { todoItem in
                listRowView(todoItem)
            }
            .frame(width: 390)
        }
    }
}

private extension TodosListView {
    func listRowView(_ todoItem: TodoItem) -> some View {
        Button {
            tapItem(todoItem)
        } label: {
            HStack(spacing: 16) {
                imageStatusFor(todoItem)
                Text(todoItem.title)
                    .ibmPlexSans(.semiBold, size: 17)
                    .foregroundColor(.darkWhite)
                Spacer()
                circleStatusFor(todoItem)
            }
            .foregroundColor(.clear)
        }
        .padding(.all)
    }
    
    func imageStatusFor(_ todoItem: TodoItem) -> some View {
        ZStack {
            Circle()
                .fill(Color.darkGray)
                .frame(width: 40)
            Image(systemName: imageSystemNameFor(todoItem.completed))
                .font(.system(size: 20))
                .foregroundColor(todoItem.completed ? .acidGreen : .lightGray)
        }
    }
    
    func circleStatusFor(_ todoItem: TodoItem) -> some View {
        Group {
            Circle()
                .frame(width: 8)
                .foregroundColor(todoItem.completed ? .acidGreen : .red)
        }
    }
    
    func imageSystemNameFor(_ isCompleted: Bool) -> String {
        isCompleted ? String.Icon.checkmark : String.Icon.multiply
    }
}
