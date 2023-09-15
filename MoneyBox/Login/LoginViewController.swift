import UIKit

class LoginViewController: UIViewController {
    
    // Force unwrap since the view controller doesn't make sense without a view model.
    // This would be a developer error.
    var viewModel: LoginViewModel!

    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: LoginTextField!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var passwordTextField: LoginTextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var authenticateButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        configureViews()
        
        #if DEBUG
        addDebugGesture()
        #endif
    }
    
    @IBAction private func authenticate() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        viewModel.authenticate(email: email, password: password)
    }
    
    #if DEBUG
    private func addDebugGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(debugAuthenticate))
        tapGesture.numberOfTapsRequired = 3
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func debugAuthenticate() {
        viewModel.authenticate(email: "test+ios2@moneyboxapp.com",
                               password: "P455word12")
    }
    #endif
}

extension LoginViewController {
        
    private func configureViews() {
        configure(emailLabel, type: .email)
        configure(emailTextField, type: .email)
        configure(passwordLabel, type: .password)
        configure(passwordTextField, type: .password)
        configure(errorLabel)
        configure(authenticateButton)
    }
    
    private func configure(_ label: UILabel, type: LoginFieldType) {
        label.text = type.label
    }
    
    private func configure(_ errorLabel: UILabel) {
        errorLabel.numberOfLines = 0
        errorLabel.font = .preferredFont(forTextStyle: .body)
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = true
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

extension LoginViewController: LoginViewModelDelegate {
    func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        
        // Dismiss the error after a short time
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.errorLabel.isHidden = true
            self.errorLabel.text = nil
        }
    }
}
