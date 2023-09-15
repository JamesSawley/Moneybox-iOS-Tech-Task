import Foundation
import Networking

extension Int {
    static let paymentAmount: Int = 50
}

class AccountDetailsViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published private(set) var accountSummary: AccountSummary
    
    weak var coordinator: AccountsCoordinator?
    
    private let dataProvider: DataProviderLogic
    
    convenience init(accountSummary: AccountSummary) {
        self.init(accountSummary: accountSummary, dataProvider: DataProvider())
    }
    
    init(accountSummary: AccountSummary, dataProvider: DataProviderLogic) {
        self.accountSummary = accountSummary
        self.dataProvider = dataProvider
    }
    
    func addMoney() {
        let request = OneOffPaymentRequest(amount: .paymentAmount, investorProductID: accountSummary.id)
        dataProvider.addMoney(request: request) {
            switch $0 {
            case .success(let response):
                self.update(moneybox: response.moneybox)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func update(moneybox: Double?) {
        guard let moneybox else {
            return
        }
        accountSummary.moneybox = moneybox
        coordinator?.prefetchData()
    }
}
