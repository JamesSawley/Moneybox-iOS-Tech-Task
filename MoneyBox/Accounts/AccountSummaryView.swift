import SwiftUI

struct AccountSummaryView: View {
    
    let account: AccountSummary
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory

    var body: some View {
        // From iOS 16 we could use AnyLayout to simplify this
        if largeSizeCategories.contains(sizeCategory) {
            VStack(alignment: .leading) {
                currentValue(for: account)
                moneybox(for: account, alignment: .leading)
            }
        } else {
            HStack {
                currentValue(for: account)
                Spacer()
                moneybox(for: account, alignment: .trailing)
            }
        }
    }
    
    @ViewBuilder func currentValue(for account: AccountSummary) -> some View {
        PrimaryValueView(title: "Current value",
                         value: account.planValue.currencyString)
    }
    
    @ViewBuilder func moneybox(for account: AccountSummary, alignment: HorizontalAlignment) -> some View {
        PrimaryValueView(title: "Moneybox",
                         value: account.moneybox.currencyString,
                         alignment: alignment)
    }
}
