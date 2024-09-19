import SwiftUI

struct BackgroundStack<Content: View>: View {
    var content: () -> Content
    var alignment: Alignment
    
    init(alignment: Alignment = .center, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.alignment = alignment
    }
    
    var body: some View {
        ZStack(alignment: alignment) {
            Color(.background)
                .ignoresSafeArea()
            content()
        }
    }
}
