import Foundation
import Networking

class AccountsViewModel: ObservableObject {

    @Published var errorMessage = "" // TODO
    @Published var accounts: AccountResponse?
    
    var helloMessage: String {
        guard let firstName = UserProvider.user?.firstName else {
            return "Hello!"
        }
        return "Hello \(firstName)!"
    }
    
    var planValue: String? {
        accounts?.totalPlanValue?.currencyString
    }

    weak var coordinator: AccountsCoordinator?
    
    private let dataProvider: DataProviderLogic
    
    // Using a convenience init to clearly separate the init that is used in
    // the app vs the init that is used in unit tests.
    convenience init() {
        self.init(dataProvider: DataProvider())
    }
    
    init(dataProvider: DataProviderLogic) {
        self.dataProvider = dataProvider
    }
    
    func fetchAccounts() {
        dataProvider.fetchProducts { result in
            switch result {
            case .success(let success):
                self.accounts = success
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
            }
        }
    }
    
    func didTap(account: AccountSummary) {
        coordinator?.showDetail(for: account)
    }
    
    func finish() {
        coordinator?.finish()
    }

}
