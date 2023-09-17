import Networking
import SwiftUI

struct AccountsView: View {
    @ObservedObject var viewModel: AccountsViewModel
    
    var body: some View {
        VStack {
            Button {
                viewModel.finish()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
            }
            
            if let accounts = viewModel.accounts {
                accountsView(accounts)
            } else {
                loadingView()
            }
        }
        .onAppear {
            viewModel.fetchAccounts()
        }
    }
    
    @ViewBuilder
    private func accountsView(_ accounts: AccountResponse) -> some View {
        VStack(alignment: .leading) {
            Text(viewModel.helloMessage)
            if let planValue = viewModel.planValue {
                Text(planValue)
            }
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    ForEach(accounts.accountDetails) {
                        accountRow($0)
                    }
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func loadingView() -> some View {
        if #available(iOS 14.0, *) {
            ProgressView()
        } else {
            Text("Fetching your accounts")
            // TODO: Wrap UIKit spinner for SwiftUI iOS 13
        }
    }
    
    @ViewBuilder
    private func accountRow(_ account: AccountSummary) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(account.name)
                    .font(.title)
                Text(account.planValue.currencyString)
                Text(account.moneybox.currencyString)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16)
        }
        .frame(maxWidth: .infinity)
        .background(Color.grey)
        .cornerRadius(8)
        .onTapGesture {
            viewModel.didTap(account: account)
        }
    }
}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView(viewModel: AccountsViewModel())
            .preferredColorScheme(.dark)
        AccountsView(viewModel: AccountsViewModel())
            .preferredColorScheme(.light)
    }
}
