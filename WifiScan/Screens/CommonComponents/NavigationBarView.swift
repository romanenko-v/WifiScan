import SwiftUI

struct NavigationBarView<Content: View>: View {
    let title: String
    let titleColor: Color?
    let buttonColor: Color
    let leadingButton: NavigationButton?
    let trailingButton: NavigationButton?
    let content: Content

    init(
        title: String,
        titleColor: Color? = .darkWhite,
        buttonColor: Color = .black,
        leadingButton: NavigationButton? = nil,
        trailingButton: NavigationButton? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.titleColor = titleColor
        self.buttonColor = buttonColor
        self.leadingButton = leadingButton
        self.trailingButton = trailingButton
        self.content = content()
    }

    var body: some View {
        ZStack {
            content
                .padding(.top)
            
            VStack(spacing: 0) {
                BackgroundStack {
                    HStack {
                        leadingButton?.view(buttonColor: buttonColor)
                            .padding(.leading, 22)
    
                        Spacer()
                        trailingButton?.view(buttonColor: buttonColor)
                            .padding(.trailing, 22)
                    }
                    Text(title)
                        .ibmPlexSans(.bold, size: 20)
                        .foregroundStyle(titleColor ?? .darkWhite)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 40)
                .frame(maxHeight: .infinity, alignment: .top)
                Spacer()
            }
        }
    }
}

enum NavigationButton {
    case back(action: () -> Void)
    
    @ViewBuilder
    func view(buttonColor: Color) -> some View {
        switch self {
        case .back(let action):
            Button(action: action) {
                Image(systemName: String.Icon.back)
                    .font(.system(size: 22))
                    .foregroundColor(buttonColor)
            }
        }
    }
}
