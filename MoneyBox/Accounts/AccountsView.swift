import Networking
import SwiftUI

struct AccountsView: View {
    
    @ObservedObject var viewModel: AccountsViewModel
    
    @State var showLogoutWarning = false
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.helloMessage)
                    .modifier(LargeFontModifier())
                Spacer()
                Button {
                    showLogoutWarning = true
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .alert(isPresented: $showLogoutWarning) {
                    Alert(title: Text("Log out"),
                          message: Text("Are you sure you want to log out?"),
                          primaryButton: .cancel(Text("Cancel"), action: {}),
                          secondaryButton: .destructive(Text("Log out"), action: viewModel.finish))
                }
            }
            
            if let accounts = viewModel.accounts {
                accountsView(accounts)
            } else {
                loadingView()
            }
        }
        .foregroundColor(.typography)
        .padding()
        .onAppear {
            viewModel.fetchAccounts()
        }
    }
    
    @ViewBuilder
    private func accountsView(_ accounts: AccountResponse) -> some View {
        VStack(alignment: .leading) {
            if let planValue = viewModel.planValue {
                PrimaryValueView(title: "Plan Value",
                                 titleFont: .body,
                                 value: planValue,
                                 valueFont: .system(size: 48))
            }
            
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    ForEach(accounts.accountDetails) {
                        accountRow($0)
                    }
                }
            }
        }
        .padding(.top)
    }
    
    @ViewBuilder
    private func loadingView() -> some View {
        VStack {
            Spacer()
            Spinner()
            Spacer()
        }
    }
    
    @ViewBuilder
    private func accountRow(_ account: AccountSummary) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(account.name)
                    .font(.title)
                
                AccountSummaryView(account: account)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16)
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
        .modifier(AccountTileModifier())
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
