import XCTest

@testable import MoneyBox

final class DoubleExtensionTests: XCTestCase {

    func test_currencyString_formatsGBP() {
        let value: Double = 123456.789
        XCTAssertEqual(value.currencyString, "£123,456.79")
    }
    
    func test_currencyString_roundsUpFromHalf() {
        let value1: Double = 10.005
        XCTAssertEqual(value1.currencyString, "£10.01")
        
        let value2: Double = 10.0049
        XCTAssertEqual(value2.currencyString, "£10.00")
    }

}
