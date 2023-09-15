import Foundation
import Networking

struct AccountSummary: Identifiable {
    let id: Int
    let name: String
    let planValue: Double
    let moneybox: Double
    
    var planValueString: String {
        "Plan Value: \(planValue.currencyString)"
    }
    
    var moneyboxString: String {
        "Moneybox: \(moneybox.currencyString)"
    }
}

extension AccountResponse {
    var accountDetails: [AccountSummary] {
        productResponses?.compactMap({ $0.accountDetail }) ?? []
    }
}

extension ProductResponse {
    // Let's keep the UI cleaner by filtering out any accounts without the correct information
    var accountDetail: AccountSummary? {
        guard let id = product?.id,
              let name = product?.friendlyName else {
            return nil
        }
        return AccountSummary(id: id,
                             name: name,
                             planValue: planValue ?? 0,
                             moneybox: moneybox ?? 0)
    }
}
