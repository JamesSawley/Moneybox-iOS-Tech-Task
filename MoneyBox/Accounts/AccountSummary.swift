import Foundation
import Networking

struct AccountSummary: Identifiable {
    let id: Int
    let name: String
    let planValue: Double
    var moneybox: Double

    // Product information
    let interestRate: String?
    let annualLimit: Int?
    
    var hasProductInformation: Bool {
        interestRate != nil
            || annualLimit != nil
    }
    
    static var preview: Self {
        .init(id: 0,
              name: "Stocks and Shares ISA",
              planValue: 1000.00,
              moneybox: 50.00,
              interestRate: "0.35% AER",
              annualLimit: 4000)
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
        guard let id = id,
              let name = product?.friendlyName else {
            return nil
        }
        return AccountSummary(id: id,
                              name: name,
                              planValue: planValue ?? 0,
                              moneybox: moneybox ?? 0,
                              interestRate: product?.interestRate,
                              annualLimit: product?.annualLimit)
    }
}
