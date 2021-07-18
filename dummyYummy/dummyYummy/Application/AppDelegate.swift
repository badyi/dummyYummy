//
//  AppDelegate.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
        if let statusBarFrame = window?.windowScene?.statusBarManager?.statusBarFrame {
            let statusBarView = UIView(frame: statusBarFrame)
            statusBarView.backgroundColor = UIColor(hexString: "#121212")
            self.window?.addSubview(statusBarView)
        }
        
        
        appCoordinator = AppCoordinator(navigationController)
        appCoordinator?.start()
        
        return true
    }
}

