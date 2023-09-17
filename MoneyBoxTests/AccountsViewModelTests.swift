import Networking
import XCTest

@testable import MoneyBox

final class AccountsViewModelTests: XCTestCase {
    
    private var dataProvider: DataProviderLogicMock!
    private var viewModel: AccountsViewModel!
    
    override func setUp() {
        super.setUp()
        dataProvider = DataProviderLogicMock()
        viewModel = AccountsViewModel(dataProvider: dataProvider)
        
        UserProvider.user = nil
    }

    func test_helloMessage_noUser() throws {
        UserProvider.user = nil
        XCTAssertEqual(viewModel.helloMessage, "Hello!")
    }

    func test_helloMessage_validUser() throws {
        let data = """
        {
            "Email": "test+ios@moneyboxapp.com",
            "FirstName": "Michael",
            "LastName": "Jordan"
        }
        """.data(using: .utf8)!
        let user = try JSONDecoder().decode(LoginResponse.User.self, from: data)
        UserProvider.user = user
    }
    
    func test_fetchAccounts_failure() throws {
        dataProvider.fetchProductsReturnValue = .failure(MockError.failure)
        
        viewModel.fetchAccounts()
        
        XCTAssertEqual(viewModel.errorMessage, "error")
        XCTAssertNil(viewModel.accounts)
        XCTAssertNil(viewModel.planValue)
    }
    
    func test_fetchAccounts_success() throws {
        dataProvider.fetchProductsReturnValue = StubData.read(file: "Accounts")
        
        viewModel.fetchAccounts()
        
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
        XCTAssertNotNil(viewModel.accounts)
        XCTAssertEqual(viewModel.planValue, "£15,707.08")
    }
}
