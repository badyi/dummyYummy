//
//  CoordinatorProtocol.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    // Each coordinator has one navigation controller assigned to it.
    var navigationController: UINavigationController { get set }
    /// Array to keep tracking of all child coordinators.
    var childCoordinators: [Coordinator] { get set }
    /// Defined flow type.
    var type: CoordinatorType { get }
    /// A place to put logic to start the flow.
    func start()
    func finish()

    func showErrorAlert(with text: String)

    init(_ navigationController: UINavigationController)
}

 extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }

    func showErrorAlert(with text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        DispatchQueue.main.async { [weak self] in
            self?.navigationController.present(alert, animated: true, completion: nil)
        }
    }
 }

// MARK: - CoordinatorOutput
/// Delegate protocol helping parent Coordinator know when its child is ready to be finished.
 protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
 }

// MARK: - CoordinatorType
/// Using this structure we can define what type of flow we can use in-app.
enum CoordinatorType {
    case app, feedSearch, fridge, favorite, tab, detail
}
