import SwiftUI

struct AccountDetailsView: View {
    
    @ObservedObject var viewModel: AccountDetailsViewModel

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                let account = viewModel.accountSummary
                Group {
                    Text(account.name)
                        .font(.largeTitle)
                    
                    VStack {
                        AccountSummaryView(account: account)
                        if account.hasProductInformation {
                            Divider()
                            VStack(spacing: 8) {
                                if let interestRate = account.interestRate {
                                    AccountFooterView(footnote: "Interest rate",
                                                      value: interestRate)
                                }
                                if let annualLimit = account.annualLimit {
                                    AccountFooterView(footnote: "Annual limit",
                                                      value: Double(annualLimit).currencyString)
                                }
                            }
                        }
                    }
                    .modifier(AccountTileModifier())
                }
                .foregroundColor(.typography)
                Spacer()
                Button {
                    viewModel.addMoney()
                } label: {
                    Text("Add £10")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .accentColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(.cornerRadius)
                }
                .accessibility(identifier: "addMoney")
            }
            .padding()
        }
    }
}

struct AccountDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AccountDetailsViewModel(accountSummary: AccountSummary.preview)
        AccountDetailsView(viewModel: viewModel)
            .preferredColorScheme(.dark)
            .background(Color.background)
        
        AccountDetailsView(viewModel: viewModel)
            .preferredColorScheme(.light)
    }
}
