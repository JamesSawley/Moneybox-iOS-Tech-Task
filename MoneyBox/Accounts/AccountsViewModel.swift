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
        guard let value = accounts?.totalPlanValue else {
            return nil
        }
        return "Plan Value: \(value.currencyString)"
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
    
    func didTap(product: ProductResponse) {
        coordinator?.showDetail(for: product)
    }
    
    func finish() {
        coordinator?.finish()
    }

}
