import SwiftUI

struct AccountFooterView: View {

    let footnote: String
    let value: String
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory

    var body: some View {
        // From iOS 16 we could use AnyLayout to simplify this
        if largeSizeCategories.contains(sizeCategory) {
            VStack {
                Text(footnote)
                Text(value)
                    .fontWeight(.bold)
            }
            .font(.footnote)
        } else {
            HStack {
                Text(footnote)
                Spacer()
                Text(value)
                    .fontWeight(.bold)
            }
            .font(.footnote)
        }
    }
}
