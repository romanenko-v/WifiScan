import SwiftUI

extension Image {
    func imageStyle(_ color: Color) -> some View {
        self
            .frame(width: 16, height: 16)
            .foregroundColor(color)
    }
}
