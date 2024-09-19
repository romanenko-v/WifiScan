import SwiftUI

@main
struct WifiScanApp: App {
    @AppStorage("isShouldShowOnboarding") var isShouldShowOnboarding: Bool = true
    @State var launcher = AppLauncher()
    @State var launchState: AppLauncher.LaunchState = .coordinator
    @State var coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            bodyContentView(launchState)
//                .onAppear {
//                    launcher.load()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
//                        launchState = isShouldShowOnboarding ? .onboarding : .coordinator
//                    }
//                }
        }
    }
}

private extension WifiScanApp {
    @ViewBuilder
    func bodyContentView(_ launchState: AppLauncher.LaunchState) -> some View {
        switch launchState {
        case .onboarding: EmptyView()
        case .loading: EmptyView()
        case .coordinator: CoordinatorView()
        case .paywall: EmptyView()
        }
    }
}
