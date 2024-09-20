import SwiftUI

struct WifiButtonView: View {
    @Binding var fetchingStatus: FetchStatus
    let tapButton: () -> ()
    
    @State private var scales: [CGFloat] = [1.0, 1.0, 1.0, 1.0]
    private let animationDuration: Double = 3.0
    
    var body: some View {
        ZStack {
            animatedCircles
            Button {
                tapButton()
            } label: {
                Image(String.Icon.wifi)
                    .foregroundColor(colorFor(fetchingStatus))
            }
        }
        .onChange(of: fetchingStatus) { newValue in
            if newValue == .fetching {
                startAnimation()
            } else {
                finishAnimation()
            }
        }
    }
}

private extension WifiButtonView {
    func colorFor(_ fetchingStatus: FetchStatus) -> Color {
        fetchingStatus == .initial ? .darkWhite : .acidGreen
    }
    
    func circleColorFor(_ fetchingStatus: FetchStatus) -> Color {
        fetchingStatus == .initial ? .darkGray : .acidGreen
    }
    
    var animatedCircles: some View {
        ZStack {
            ForEach(0..<scales.count, id: \.self) { index in
                Circle()
                    .scaleEffect(scales[index])
                    .frame(width: 310 - CGFloat(index) * 50)
                    .foregroundColor(circleColorFor(fetchingStatus).opacity(0.06 + Double(index) * 0.03))
            }
        }
    }
    
    func startAnimation() {
        withAnimation(.easeIn(duration: animationDuration).repeatForever()) {
            scales = [1.2, 1.2, 1.2, 1.2]
        }
    }
    
    func finishAnimation() {
        withAnimation(.easeInOut) {
            scales = [1.0, 1.0, 1.0, 1.0]
        }
    }
}
