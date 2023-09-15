import Combine
import Foundation
import Networking

protocol SessionManagerDelegate: AnyObject {
    func logout()
}

protocol SessionManager {
    var delegate: SessionManagerDelegate? { get set }
    
    func setUserToken(_ token: String)
    func removeUserToken()
}

class ConcreteSessionManager: SessionManager {
    
    // Using a singleton since there should only ever be one SessionManager and the
    // instance should exist throughout the entire app lifecycle
    static let shared = ConcreteSessionManager()
    
    weak var delegate: SessionManagerDelegate?
    private var timer: Cancellable?
    private let timeoutInterval: TimeInterval
    
    init(timeout: TimeInterval = 5 * 60) {
        timeoutInterval = timeout
    }
    
    func setUserToken(_ token: String) {
        Authentication.token = token
        setTimeout()
    }
    
    func removeUserToken() {
        Authentication.token = nil
        timer = nil
    }
    
    private func setTimeout() {
        timer = Timer.publish(every: timeoutInterval, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.removeUserToken()
                self?.delegate?.logout()
                self?.timer = nil
            }
    }
}
