import Networking
import SwiftUI
import UIKit

protocol AccountsCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: AccountsCoordinator)
}

class AccountsCoordinator: Coordinator {
    
    private let rootViewController: UINavigationController
    private weak var delegate: AccountsCoordinatorDelegate?
    private lazy var viewModel = AccountsViewModel()
    
    init(rootViewController: UINavigationController, delegate: AccountsCoordinatorDelegate) {
        self.rootViewController = rootViewController
        self.delegate = delegate
    }

    override func start() {
        viewModel.coordinator = self
        let view = AccountsView(viewModel: viewModel)
            .accessibility(identifier: "Accounts")
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .fullScreen
        hostingController.setBackground()
        rootViewController.present(hostingController, animated: true) {
            self.rootViewController.viewControllers = []
        }
    }
    
    override func finish() {
        self.delegate?.didFinish(from: self)
        rootViewController.presentedViewController?.dismiss(animated: true)
    }
}

extension AccountsCoordinator {
    func showDetail(for account: AccountSummary) {
        let viewModel = AccountDetailsViewModel(accountSummary: account)
        viewModel.coordinator = self
        let view = AccountDetailsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        hostingController.setBackground()
        if #available(iOS 15.0, *) {
            // TODO: Create method to improve reusability
            let detents: [UISheetPresentationController.Detent]
            if largeUIKitSizeCategories.contains(UIApplication.shared.preferredContentSizeCategory) {
                detents = [.large()]
            } else {
                detents = [.medium()]
            }
            if let sheet = hostingController.sheetPresentationController {
                sheet.detents = detents
            }
        }
        rootViewController.presentedViewController?.present(hostingController, animated: true)
    }
    
    func prefetchData() {
        viewModel.fetchAccounts()
    }
}
