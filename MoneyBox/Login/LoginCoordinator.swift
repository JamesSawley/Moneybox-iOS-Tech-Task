import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: LoginCoordinator)
}

class LoginCoordinator: Coordinator {
    
    private let rootViewController: UINavigationController
    private weak var delegate: LoginCoordinatorDelegate?
    
    init(rootViewController: UINavigationController, delegate: LoginCoordinatorDelegate) {
        self.rootViewController = rootViewController
        self.delegate = delegate
    }
    
    override func start() {
        let storyboard = UIStoryboard(name: "Login", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
        guard let viewController else {
            return
        }
        let viewModel = LoginViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        rootViewController.viewControllers = [viewController]
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}
