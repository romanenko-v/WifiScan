import SwiftUI

struct BackgroundContainer<Content: View>: View {
    var content: () -> Content
    var contentAlignment: Alignment
    var cornerRadius: CGFloat
    var opacity: Double
    var backgroundColor: Color
    var width: CGFloat
    var verticalPadding: CGFloat
    
    init(
        contentAlignment: Alignment = .center,
        width: CGFloat = 343,
        cornerRadius: CGFloat = 18,
        verticalPadding: CGFloat = 16,
        opacity: Double = 1,
        backgroundColor: Color = .darkGray,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.cornerRadius = cornerRadius
        self.opacity = opacity
        self.width = width
        self.verticalPadding = verticalPadding
        self.backgroundColor = backgroundColor
        self.contentAlignment = contentAlignment
    }
    
    var body: some View {
        ZStack {
            content()
                .padding(.horizontal, 20)
                .padding(.vertical, verticalPadding)
                .background(
                    Rectangle()
                        .fill(backgroundColor.opacity(opacity))
                        .cornerRadius(cornerRadius)
                        .frame(width: width)
                )
        }
        .frame(width: width)
    }
}
