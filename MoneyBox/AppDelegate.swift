import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
        if CommandLine.arguments.contains("-uiTesting") {
            UserDefaults.standard.set(nil, forKey: .savedEmailKey)
        }
        #endif
        
        window = UIWindow()
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        
        return true
    }
}

