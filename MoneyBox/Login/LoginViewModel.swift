import Foundation
import Networking

protocol LoginViewModelDelegate: AnyObject {
    func showError(message: String)
}

extension String {
    static let savedEmailKey: String = "LoginViewModel.SavedEmail"
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    weak var coordinator: LoginCoordinator?
    
    private let dataProvider: DataProviderLogic
    private let sessionManager: SessionManager
    private let userDefaults: UserDefaultsType
    
    var savedEmail: String? {
        userDefaults.string(forKey: .savedEmailKey)
    }
    
    convenience init() {
        self.init(dataProvider: DataProvider(),
                  sessionManager: ConcreteSessionManager.shared,
                  userDefaults: UserDefaults.standard)
    }
    
    init(dataProvider: DataProviderLogic,
         sessionManager: SessionManager,
         userDefaults: UserDefaultsType) {
        self.dataProvider = dataProvider
        self.sessionManager = sessionManager
        self.userDefaults = userDefaults
    }
    
    func authenticate(email: String?, password: String?) {
        do {
            try validate(email: email, password: password)
        } catch {
            self.delegate?.showError(message: error.localizedDescription)
            return
        }

        guard let email, let password else { return }
        save(email: email)
        
        let request = LoginRequest(email: email, password: password)
        dataProvider.login(request: request) { result in
            switch result {
            case .success(let success):
                self.authenticated(response: success)
            case .failure(let failure):
                // TODO: Convert error message into something the user will understand
                self.delegate?.showError(message: failure.localizedDescription)
            }
        }
    }
    
    private func validate(email: String?, password: String?) throws {
        guard let email, password != nil else {
            throw LoginError.missingEmailOrPassword
        }
        
        // Doing minimal client side validation of email address
        guard email.contains(where: { $0 == "@" }) else {
            throw LoginError.invalidEmail
        }
    }
    
    private func authenticated(response: LoginResponse) {
        sessionManager.setUserToken(response.session.bearerToken)
        UserProvider.user = response.user
        coordinator?.finish()
    }
    
    private func save(email: String) {
        userDefaults.set(email, forKey: .savedEmailKey)
    }
}

enum LoginError: LocalizedError {
    case invalidEmail
    case missingEmailOrPassword
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Your email address is invalid. Please try again."
        case .missingEmailOrPassword:
            return "Please enter your email address and password"
        }
    }
}
