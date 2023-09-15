import Foundation

@testable import MoneyBox

class SessionManagerMock: SessionManager {
    
    var methodsCalled = [String]()

    var delegate: SessionManagerDelegate?
    
    var token: String?
    func setUserToken(_ token: String) {
        methodsCalled.append(#function)
        self.token = token
    }
    
    func removeUserToken() {
        methodsCalled.append(#function)
    }
    
    
}
