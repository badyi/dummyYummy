//
//  Assembly.swift
//  dummyYummy
//
//  Created by badyi on 28.07.2021.
//

import UIKit

protocol AppAssemblyProtocol {
    func createGuideModule(navigationDelegate: GuideNavigationDelegate) -> GuidePageViewController
}

final class AppAssembly {
    func createGuideModule(navigationDelegate: GuideNavigationDelegate) -> GuidePageViewController {

        let pageViewController = GuidePageViewController(transitionStyle: .scroll,
                                                         navigationOrientation: .horizontal,
                                                         options: nil)
        let page1 = GuideViewController()
        let page2 = GuideViewController()
        let page3 = GuideViewController()
        let page4 = GuideViewController()
        page1.setImage(UIImage(named: "FeedGuide") ?? UIImage())
        page2.setImage(UIImage(named: "DetailGuide") ?? UIImage())
        page3.setImage(UIImage(named: "FridgeGuide") ?? UIImage())
        page4.setImage(UIImage(named: "FavoritesGuide") ?? UIImage())
        let pages: [GuideViewController] = [page1, page2, page3, page4]
        let guidePresenter = GuidePresenter(with: pageViewController, pages)
        guidePresenter.navigationDelegate = navigationDelegate
        pageViewController.presenter = guidePresenter

        return pageViewController
    }
 }
