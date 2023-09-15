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
        let hostingController = UIHostingController(rootView: view)
        rootViewController.viewControllers = [hostingController]
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension AccountsCoordinator {
    func showDetail(for account: AccountSummary) {
        let viewModel = AccountDetailsViewModel(accountSummary: account)
        let view = AccountDetailsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        rootViewController.present(hostingController, animated: true)
    }
    
    func prefetchData() {
        viewModel.fetchAccounts()
    }
}
