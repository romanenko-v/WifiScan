import SwiftUI

final class AppLauncher {
    enum LaunchState {
        case onboarding
        case loading
        case coordinator
        case paywall
    }

    var stateChangeHandler: ((LaunchState) -> Void)?
    
    var launchState: LaunchState {
        get {
            return _launchState
        }
        set {
            _launchState = newValue
        }
    }

    private var _launchState = LaunchState.onboarding {
        didSet {
            stateChangeHandler?(_launchState)
        }
    }

    func onboarding() {
        launchState = .onboarding
    }
    
    func load() {
        launchState = .loading
    }
}
