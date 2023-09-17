import XCTest

@testable import MoneyBox

final class AccountSummaryTests: XCTestCase {

    func test_hasProductInformation_false() {
        let summary = AccountSummary(id: 0, name: "foo", planValue: 10, moneybox: 10, interestRate: nil, annualLimit: nil)
        XCTAssertFalse(summary.hasProductInformation)
    }
    
    func test_hasProductInformation_true() {
        let interestRate = AccountSummary(id: 0, name: "foo", planValue: 10, moneybox: 10, interestRate: "foo", annualLimit: nil)
        XCTAssertTrue(interestRate.hasProductInformation)
        
        let annualLimit = AccountSummary(id: 0, name: "foo", planValue: 10, moneybox: 10, interestRate: nil, annualLimit: 1)
        XCTAssertTrue(annualLimit.hasProductInformation)
    }

}
