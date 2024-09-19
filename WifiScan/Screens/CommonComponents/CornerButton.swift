import SwiftUI

struct CornerButton: View {
    var text: String
    var isActive: Bool
    var width: CGFloat
    var action: () -> ()
    
    init(text: String,
         isActive: Bool,
         width: CGFloat = Constants.width,
         action: @escaping () -> ()
    ) {
        self.text = text
        self.isActive = isActive
        self.width = width
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            BackgroundContainer(width: width,
                                cornerRadius: Constants.cornerRadius,
                                verticalPadding: Constants.verticalPadding,
                                backgroundColor: backgroundColor) {
                Text(text)
                    .foregroundColor(.darkAcidGreen)
                    .ibmPlexSans(.regular, size: Constants.textSize)
            }
        }
        .disabled(!isActive)
    }
}

private extension CornerButton {
    var backgroundColor: Color {
        isActive ?
            Color.acidGreen :
            Color.acidGreen.opacity(Constants.disabledBackgroundOpacity)
    }
}

// MARK: - Constants
private extension CornerButton {
    enum Constants {
        static let cornerRadius: CGFloat = 50
        static let width: CGFloat = 155
        static let disabledBackgroundOpacity: Double = 0.3
        static let textSize: CGFloat = 14
        static let verticalPadding: CGFloat = 12
    }
}
