import Networking
import XCTest

@testable import MoneyBox

final class LoginViewModelTests: XCTestCase {
    
    private var dataProvider: DataProviderLogicMock!
    private var delegate: LoginViewModelDelegateMock!
    private var sessionManager: SessionManagerMock!
    private var userDefaults: UserDefaultsMock!
    
    private var viewModel: LoginViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dataProvider = DataProviderLogicMock()
        delegate = LoginViewModelDelegateMock()
        sessionManager = SessionManagerMock()
        userDefaults = UserDefaultsMock()
        
        viewModel = LoginViewModel(dataProvider: dataProvider,
                                   sessionManager: sessionManager,
                                   userDefaults: userDefaults)
        viewModel.delegate = delegate
        
        // TODO: Mock this properly with a protocol
        UserProvider.user = nil
    }

    func test_authenticate_missingEmail_showsErrorToUser() throws {
        viewModel.authenticate(email: nil, password: "foo")
        
        XCTAssertEqual(delegate.errorMessage, "Please enter your email address and password")
    }
    
    func test_authenticate_missingPassword_showsErrorToUser() throws {
       viewModel.authenticate(email: "foo", password: nil)
        
        XCTAssertEqual(delegate.errorMessage, "Please enter your email address and password")
    }
    
    func test_authenticate_invalidEmail_showsErrorToUser() throws {
        viewModel.authenticate(email: "foo", password: "bar")
        
        XCTAssertEqual(delegate.errorMessage, "Your email address is invalid. Please try again.")
    }
    
    func test_authenticate_savesUser() throws {
        dataProvider.loginReturnValue = StubData.read(file: "LoginSucceed")
        
        viewModel.authenticate(email: "foo@bar.com", password: "bar")
        
        XCTAssertEqual(viewModel.savedEmail, "foo@bar.com")
    }
    
    func test_authenticate_apiSuccess_persistsTokenAndUser() throws {
        dataProvider.loginReturnValue = StubData.read(file: "LoginSucceed")
        
        viewModel.authenticate(email: "foo@bar.com", password: "bar")
        
        XCTAssertEqual(sessionManager.token, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
        XCTAssertEqual(UserProvider.user?.firstName, "Michael")
        XCTAssertEqual(UserProvider.user?.lastName, "Jordan")
    }
    
    func test_authenticate_apiFailure_showsErrorToUser() throws {
        // We could simulate a failure by forcing this method to fail, or by returning our own error
//        dataProvider.loginReturnValue = StubData.read(file: "LoginFailure")
        
        dataProvider.loginReturnValue = .failure(MockError.failure)
        
        viewModel.authenticate(email: "foo@bar.com", password: "bar")
        
        XCTAssertEqual(self.delegate.errorMessage, "error")
    }

}

class LoginViewModelDelegateMock: LoginViewModelDelegate {
    var methodsCalled = [String]()
    
    var errorMessage: String?
    func showError(message: String) {
        methodsCalled.append(#function)
        errorMessage = message
    }
}

enum MockError: LocalizedError {
    case failure
    
    var errorDescription: String? {
        "error"
    }
}
