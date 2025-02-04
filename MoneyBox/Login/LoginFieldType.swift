import UIKit

enum LoginFieldType: Int {
    case email
    case password
    
    var accessibilityIdentifier: String {
        switch self {
        case .email:
            return "emailField"
        case .password:
            return "passwordField"
        }
    }
    
    // TODO: Localizations
    var label: String {
        switch self {
        case .email:
            return "Email address"
        case .password:
            return "Password"
        }
    }
    
    var returnKeyType: UIReturnKeyType {
        switch self {
        case .email:
            return .next
        case .password:
            return .done
        }
    }
    
    var isSecureTextEntry: Bool {
        switch self {
        case .email:
            return false
        case .password:
            return true
        }
    }
}
