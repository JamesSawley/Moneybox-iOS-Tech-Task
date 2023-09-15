import SwiftUI

struct AccountDetailsView: View {
    
    @ObservedObject var viewModel: AccountDetailsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            let account = viewModel.accountSummary
            Text(account.name)
                .font(.title)
            Text(account.planValueString)
            Text(account.moneyboxString)
            Spacer()
            Button("Add £10") {
                viewModel.addMoney()
            }
        }
    }
}

struct AccountDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AccountDetailsViewModel(accountSummary: AccountSummary.preview)
        AccountDetailsView(viewModel: viewModel)
    }
}
