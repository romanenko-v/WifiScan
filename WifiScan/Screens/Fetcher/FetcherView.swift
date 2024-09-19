import SwiftUI

struct FetcherView: View {
    @StateObject private var viewModel = FetcherViewModel()
    let tapShowResults: (_ todoItems: [TodoItem]) -> ()
    
    var body: some View {
        NavigationBarView(title: Constants.title) {
            BackgroundStack {
                VStack(spacing: Constants.spacing) {
                    Spacer()
                    WifiButtonView(fetchingStatus: $viewModel.fetchStatus) {
                        viewModel.startFetching()
                    }
                    Spacer()
                    FetchStatusView(fetchStatus: $viewModel.fetchStatus)
                    PanelButtonsView(fetchStatus: $viewModel.fetchStatus,
                                     isActive: $viewModel.isActiveButton,
                                     isToggled: $viewModel.isToggled) {
                        tapShowResults(viewModel.TodoItems)
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onChange(of: viewModel.fetchStatus) { newFetchStatus in
            viewModel.onChangeFetchStatus(newFetchStatus)
        }
    }
}

// MARK: - Constants
private extension FetcherView {
    enum Constants {
        static let title: String = String.Fetcher.title
        static let spacing: CGFloat = 24
    }
}
