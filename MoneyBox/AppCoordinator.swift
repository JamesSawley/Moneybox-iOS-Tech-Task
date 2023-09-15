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
    }
    
    override func finish() {
        preconditionFailure("App coordinator should not finish")
    }
}

extension AppCoordinator {
    func endLaunch() {
        let loginCoordinator = LoginCoordinator(rootViewController: rootViewController, delegate: self)
        addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
    }
    
    func navigateToAccounts() {
        // TODO
        rootViewController.viewControllers = [UIViewController()]
    }
}

extension AppCoordinator: LoginCoordinatorDelegate {
    func didFinish(from coordinator: LoginCoordinator) {
        navigateToAccounts()
        removeChildCoordinator(coordinator)
    }
}
