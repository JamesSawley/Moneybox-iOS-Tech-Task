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
                        titleWithValue(title: "Current value",
                                       value: account.planValue.currencyString)
                        Spacer()
                        titleWithValue(title: "Moneybox",
                                       value: account.moneybox.currencyString)
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
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: .cornerRadius)
                        .strokeBorder()
                )
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
        }
        .padding()
    }
    
    @ViewBuilder
    func titleWithValue(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.footnote)
            
            Text(value)
                .font(.title)
        }
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
