import SwiftUI
import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow?
    
    lazy var rootViewController = UINavigationController(rootViewController: launchAnimationController)
        
    private var launchAnimationController: LaunchAnimationController {
        let viewController = LaunchAnimationController()
        viewController.coordinator = self
        return viewController
    }
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        ConcreteSessionManager.shared.delegate = self
    }
    
    override func finish() {
        preconditionFailure("App coordinator should not finish")
    }
}

extension AppCoordinator: SessionManagerDelegate {
    func logout() {
        navigateToLogin()
    }
}

extension AppCoordinator {
    func navigateToLogin() {
        let loginCoordinator = LoginCoordinator(rootViewController: rootViewController, delegate: self)
        addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
    }
    
    func navigateToAccounts() {
        let accountsCoordinator = AccountsCoordinator(rootViewController: rootViewController, delegate: self)
        addChildCoordinator(accountsCoordinator)
        accountsCoordinator.start()
    }
}

extension AppCoordinator: LoginCoordinatorDelegate {
    func didFinish(from coordinator: LoginCoordinator) {
        navigateToAccounts()
        removeChildCoordinator(coordinator)
    }
}

extension AppCoordinator: AccountsCoordinatorDelegate {
    func didFinish(from coordinator: AccountsCoordinator) {
        navigateToLogin()
        removeChildCoordinator(coordinator)
    }
}
