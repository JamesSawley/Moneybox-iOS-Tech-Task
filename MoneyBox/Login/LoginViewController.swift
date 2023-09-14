import UIKit

class LoginViewController: UIViewController {
    
    // TODO: Create Coordinator?
    private lazy var viewModel = LoginViewModel()

    @IBOutlet private weak var emailTextField: LoginTextField!
    @IBOutlet private weak var passwordTextField: LoginTextField!
    @IBOutlet private weak var authenticateButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    @IBAction private func authenticate() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        viewModel.authenticate(email: email, password: password)
    }
}

extension LoginViewController {
        
    private func configureViews() {
        configure(emailTextField, type: .email)
        configure(passwordTextField, type: .password)
        configure(authenticateButton)
    }
    
    private func configure(_ textField: LoginTextField, type: LoginFieldType) {
        textField.delegate = self
        textField.configure(with: type)
    }
    
    private func configure(_ button: UIButton) {
        // TODO: Localization
        button.setTitle("Login", for: .normal)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case LoginFieldType.email.rawValue:
            passwordTextField.becomeFirstResponder()
        case LoginFieldType.password.rawValue:
            passwordTextField.resignFirstResponder()
        default:
            // Using preconditionFailure since this would be a developer error, and it
            // would be better to catch the bug early in development / automated tests
            // with the crash rather than find a stealthy bug later.
            preconditionFailure("Unknown text field")
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let loginTextField = textField as? LoginTextField else {
            return
        }
        loginTextField.updateForEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let loginTextField = textField as? LoginTextField else {
            return
        }
        loginTextField.updateForEditing()
    }
}
