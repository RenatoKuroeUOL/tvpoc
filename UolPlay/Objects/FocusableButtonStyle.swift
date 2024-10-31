import SwiftUI

struct FocusableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(configuration.isPressed ? .black : .white)  // Black when focused (pressed)
            .background(Color.gray)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)  // Optional: Add scale effect when pressed
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
