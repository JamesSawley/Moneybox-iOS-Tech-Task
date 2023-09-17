import SwiftUI

struct AccountTileModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .strokeBorder()
            )
    }
}
