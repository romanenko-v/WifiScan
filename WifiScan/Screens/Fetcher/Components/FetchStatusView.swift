import SwiftUI

struct FetchStatusView: View {
    @Binding var fetchStatus: FetchStatus
    
    var body: some View {
        BackgroundContainer(opacity: Constants.backgroundOpacity) {
            switch fetchStatus {
            case .initial:
                labelViewFor(String.Fetcher.tapOnTheButton, String.Icon.handTap)
            case .fetching:
                labelViewFor(String.Fetcher.itWillTake)
            case .finish:
                labelViewFor(String.Fetcher.fetchSuccessfully, String.Icon.exclamationMark)
            }
        }
    }
}

// MARK: - private methods
private extension FetchStatusView {
    func labelViewFor(_ text: String, _ image: String? = nil) -> some View {
        HStack(spacing: Constants.labelSpacing) {
            if let image = image {
                Image(systemName: image)
                    .font(.system(size: Constants.imageSystemSize))
                    .foregroundColor(.lightGray)
                    .rotationEffect(rotationEffectFor(image))
            } else {
                ProgressView()
                    .frame(width: Constants.progressViewSize, height: Constants.progressViewSize)
                    .scaleEffect(Constants.progressViewScaleEffect)
                    .tint(.lightGray)
            }
            Text(text)
                .ibmPlexSans(.semiBold, size: Constants.textSize)
                .foregroundColor(.lightGray)
            Spacer()
        }
    }
    
    func rotationEffectFor(_ imageSystemName: String) -> Angle {
        imageSystemName == String.Icon.handTap ? Constants.rotationDegrees : Constants.defaultDegrees
    }
}

// MARK: - Constants
private extension FetchStatusView {
    enum Constants {
        static let backgroundOpacity: Double = 0.6
        static let defaultDegrees: Angle = .degrees(0)
        static let rotationDegrees: Angle = .degrees(15)
        static let textSize: CGFloat = 14
        static let progressViewSize: CGFloat = 28
        static let progressViewScaleEffect: Double = 1.3
        static let imageSystemSize: CGFloat = 24
        static let labelSpacing: CGFloat = 10
    }
}
