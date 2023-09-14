import UIKit

class AppCoordinator {
    
    lazy var rootViewController = UINavigationController(rootViewController: launchAnimationController)
    
    private var homeViewModel: HomeViewModel?
    
    private var launchAnimationController: LaunchAnimationController {
        let viewController = LaunchAnimationController()
        viewController.coordinator = self
        return viewController
    }
        
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
        
        guard let viewController else { return }
        rootViewController.viewControllers = [viewController]
    }
}
