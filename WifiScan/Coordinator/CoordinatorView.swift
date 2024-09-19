import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()

    var body: some View {
        ZStack {
            TabView(selection: $coordinator.selectedTab) {
                NavigationStack(path: $coordinator.path) {
                    coordinator.build(coordinator.selectedTab)
                        .navigationDestination(for: Screen.self) { page in
                            coordinator.build(page)
                                .navigationBarBackButtonHidden()
                        }
                        .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                            coordinator.build(fullScreenCover)
                        }
                        .sheet(item: $coordinator.sheet, content: { sheet in
                            coordinator.build(sheet)
                                .interactiveDismissDisabled(true)
                        })
                        .onAppear {
                            coordinator.isShouldShowTabBar = true
                        }
                        .toolbar(.hidden, for: .tabBar)
                        .tag(coordinator.selectedTab)
                }
            }
            VStack {
                Spacer()
                
                if coordinator.isShouldShowTabBar {
                    EmptyView()
                        .edgesIgnoringSafeArea(.bottom)
                        .environmentObject(coordinator)
                }
            }
        }
    }
}
