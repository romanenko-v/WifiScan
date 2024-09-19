import SwiftUI

struct PanelButtonsView: View {
    @Binding var fetchStatus: FetchStatus
    @Binding var isActive: Bool
    @Binding var isToggled: Bool
    var tapShowResults: () -> ()
    
    var body: some View {
        BackgroundContainer(cornerRadius: Constants.backgroundCornerRadius, opacity: Constants.backgroundOpacity) {
            HStack(spacing: Constants.elementSpacing) {
                CornerButton(text: Constants.buttonText, isActive: isActive) {
                    tapShowResults()
                }
                Spacer()
                ToggleSwitchView(isToggled: $isToggled, isDisabled: .constant(isDisabled))
            }
            .padding(.horizontal, Constants.horizontalPadding)
        }
    }
    
    private var isDisabled: Bool {
        fetchStatus == .initial
    }
}

// MARK: - Constants
private extension PanelButtonsView {
    enum Constants {
        static let backgroundOpacity: Double = 0.6
        static let elementSpacing: CGFloat = 10
        static let buttonText: String = String.Fetcher.showResults
        static let backgroundCornerRadius: CGFloat = 40
        static let horizontalPadding: CGFloat = -5
    }
}
