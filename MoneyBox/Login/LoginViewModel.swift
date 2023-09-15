import Foundation
import Networking

protocol LoginViewModelDelegate: AnyObject {
    func showError(message: String)
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    weak var coordinator: LoginCoordinator?
    
    private let dataProvider: DataProviderLogic
    
    convenience init() {
        self.init(dataProvider: DataProvider())
    }
    
    init(dataProvider: DataProviderLogic) {
        self.dataProvider = dataProvider
    }
    
    func authenticate(email: String?, password: String?) {
        do {
            try validate(email: email, password: password)
        } catch {
            self.delegate?.showError(message: error.localizedDescription)
            return
        }

        guard let email, let password else { return }
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
        print("Authenticated: ", response)
        Authentication.token = response.session.bearerToken
        UserProvider.user = response.user
        coordinator?.finish()
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
