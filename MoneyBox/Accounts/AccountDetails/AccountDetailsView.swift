import SwiftUI

struct AccountDetailsView: View {
    
    @ObservedObject var viewModel: AccountDetailsViewModel

    var body: some View {
        VStack {
            let account = viewModel.accountSummary
            Group {
                Text(account.name)
                    .font(.largeTitle)
                
                VStack {
                    HStack(alignment: .top) {
                        PrimaryValueView(title: "Current value",
                                         value: account.planValue.currencyString)
                        Spacer()
                        PrimaryValueView(title: "Moneybox",
                                         value: account.moneybox.currencyString,
                                         alignment: .trailing)
                            .accessibility(identifier: "moneybox")
                    }
                    if account.hasProductInformation {
                        Divider()
                        VStack(spacing: 8) {
                            if let interestRate = account.interestRate {
                                footnoteWithValue(footnote: "Interest rate",
                                                  value: interestRate)
                            }
                            if let annualLimit = account.annualLimit {
                                footnoteWithValue(footnote: "Annual limit",
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
    
    @ViewBuilder
    func footnoteWithValue(footnote: String, value: String) -> some View {
        HStack {
            Text(footnote)
            Spacer()
            Text(value)
                .fontWeight(.bold)
        }
        .font(.footnote)
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
