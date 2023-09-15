import UIKit

class LaunchAnimationController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    
    private var logoView: UIImageView = {
        let image: UIImage? = UIImage(named: "moneybox")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var centerYAnchor = logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    private lazy var finalYAnchor = logoView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                                      constant: 64 + 25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .grey
        
        view.addSubview(logoView)
        NSLayoutConstraint.activate([
            logoView.heightAnchor.constraint(equalToConstant: 50),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        centerYAnchor.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateToFinalPosition()
    }
    
    func animateToFinalPosition() {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut) {
            self.centerYAnchor.isActive = false
            self.finalYAnchor.isActive = true
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.coordinator?.endLaunch()
        }
    }
}
