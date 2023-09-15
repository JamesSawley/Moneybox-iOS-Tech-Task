import Networking
import XCTest

@testable import MoneyBox

final class SessionManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Authentication.token = nil
    }

    func test_setUserToken_savesToken() throws {
        let sessionManager = ConcreteSessionManager()
        sessionManager.setUserToken("foo")
        
        XCTAssertEqual(Authentication.token, "foo")
    }
    
    func test_setUserToken_timesOut() async throws {
        let sessionManager = ConcreteSessionManager(timeout: 0.2)
        let delegate = SessionManagerDelegateMock()
        sessionManager.delegate = delegate
        
        sessionManager.setUserToken("foo")
        
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        XCTAssertNil(Authentication.token)
        XCTAssertEqual(delegate.methodsCalled, ["logout()"])
    }

    func test_removeUserToken_invalidatesTimer() async throws {
        let sessionManager = ConcreteSessionManager(timeout: 0.1)
        let delegate = SessionManagerDelegateMock()
        sessionManager.delegate = delegate
        
        // Starts timer
        sessionManager.setUserToken("foo")
        XCTAssertEqual(Authentication.token, "foo")
        
        // Invalidates timer
        sessionManager.removeUserToken()
        XCTAssertNil(Authentication.token)
        
        try await Task.sleep(nanoseconds: 200_000_000) // 0.2 seconds
        
        // Timer would have triggered if it wasn't invalidated
        XCTAssertEqual(delegate.methodsCalled, [])
    }

}

class SessionManagerDelegateMock: SessionManagerDelegate {
    
    var methodsCalled = [String]()
    
    func logout() {
        methodsCalled.append(#function)
    }
}
