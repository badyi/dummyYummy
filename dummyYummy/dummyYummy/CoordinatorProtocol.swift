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
    /// Array to keep tracking of all child coordinators. Most of the time this array will contain only one child coordinator
    var childCoordinators: [Coordinator] { get set }
    /// Defined flow type.
    var type: CoordinatorType { get }
    /// A place to put logic to start the flow.
    func start()
    /// A place to put logic to finish the flow, to clean all children coordinators, and to notify the parent that this coordinator is ready to be deallocated
    func finish()
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
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
    case app, feed, fridge, favorite, tab
}
