import SwiftUI

struct ToggleSwitchView: View {
    @Binding var isToggled: Bool
    @Binding var isDisabled: Bool
    @State private var buttonColor = Color.darkGray
    @State private var buttonOffset: CGFloat = 0
    @State private var buttonSize: CGFloat = 40
    
    let capsuleSize: CGFloat
    
    init(isToggled: Binding<Bool>, isDisabled: Binding<Bool>, capsuleSize: CGFloat = 60) {
        self._isToggled = isToggled
        self._isDisabled = isDisabled
        self.capsuleSize = capsuleSize
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .frame(width: capsuleSize * 1.2, height: capsuleSize / 1.5)
                .foregroundStyle(buttonColor)
                .contentShape(
                    Rectangle()
                )
            Image(systemName: imageSystemName)
                .font(.system(size: 18))
                .foregroundColor(.darkAcidGreen.opacity(0.6))
                .offset(x: imageOffset)
            Circle()
                .frame(width: buttonSize, height: buttonSize)
                .foregroundStyle(.darkWhite)
                .offset(x: buttonOffset)
                .contentShape(
                    Circle()
                )
                .shadow(
                    color: Color.black.opacity(0.15),
                    radius: 8,
                    y: 3
                )
                .onTapGesture {
                    toggleButton()
                }
        }
        .onAppear {
            initializeToggleState()
        }
        .onChange(of: isToggled) { newValue in
            updateToggleState(animated: true)
        }
    }
}

private extension ToggleSwitchView {
    var imageSystemName: String {
        isToggled ? String.Icon.person : String.Icon.personSlash
    }
    
    var imageOffset: CGFloat {
        isToggled ? -capsuleSize / 4 : capsuleSize / 4
    }
    
    func initializeToggleState() {
        buttonSize = capsuleSize * 0.58
        updateToggleState(animated: false)
    }
    
    func updateToggleState(animated: Bool = true) {
        let animation = animated ? Animation.easeOut(duration: 0.3) : nil
        withAnimation(animation) {
            buttonOffset = isToggled ? capsuleSize / 3.8 : -capsuleSize / 3.8
            buttonColor = isToggled ? Color.acidGreen : Color.acidGreen.opacity(0.3)
        }
    }
    
    func toggleButton() {
        if isDisabled {
            withAnimation(.easeOut(duration: 0.3)) {
                buttonOffset = isToggled ? capsuleSize / 3.8 : -capsuleSize / 3.8
                buttonColor = isToggled ? Color.acidGreen : Color.acidGreen.opacity(0.3)
                isToggled.toggle()
            }
        }
    }
}
