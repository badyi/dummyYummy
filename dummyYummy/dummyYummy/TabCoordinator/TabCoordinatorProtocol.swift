//
//  TabCoordinatorProtocol.swift
//  dummyYummy
//
//  Created by badyi on 29.07.2021.
//

import UIKit

// Define what type of flows can be started from this Coordinator
protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }

    func selectPage(_ page: TabBarPage)

    func setSelectedIndex(_ index: Int)

    func currentPage() -> TabBarPage?
}
