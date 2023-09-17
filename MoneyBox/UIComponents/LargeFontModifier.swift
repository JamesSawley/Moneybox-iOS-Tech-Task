import SwiftUI

struct LargeFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content
                .font(.largeTitle)
        } else {
            content
                .font(.title)
        }
    }
}
