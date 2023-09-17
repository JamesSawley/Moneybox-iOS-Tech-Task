import SwiftUI

struct PrimaryValueView: View {
    let title: String
    let titleFont: Font
    let value: String
    let valueFont: Font
    let alignment: HorizontalAlignment
    
    init(title: String,
         titleFont: Font = .footnote,
         value: String,
         valueFont: Font = .title,
         alignment: HorizontalAlignment = .leading) {
        self.title = title
        self.titleFont = titleFont
        self.value = value
        self.valueFont = valueFont
        self.alignment = alignment
    }
    
    var body: some View {
        VStack(alignment: alignment) {
            Text(title)
                .font(titleFont)
            
            Text(value)
                .font(valueFont)
        }
    }
}

struct PrimaryValueView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryValueView(title: "Foo", value: "Bar")
    }
}
