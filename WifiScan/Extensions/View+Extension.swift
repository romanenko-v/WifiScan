import Foundation
import SwiftUI

extension View {
    func ibmPlexSans(_ fontStyle: IBMPlexSansFont, size: CGFloat) -> some View {
        self
            .font(.custom(fontStyle.rawValue, size: size))
    }
}

enum IBMPlexSansFont: String {
    case bold = "IBMPlexSans-Bold"
    case regular = "IBMPlexSans-Regular"
    case semiBold = "IBMPlexSans-SemiBold"
}
