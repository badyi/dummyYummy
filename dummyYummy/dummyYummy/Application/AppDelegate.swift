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

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController

        // config status bar background color
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if let statusBarFrame = window?.windowScene?.statusBarManager?.statusBarFrame {
            let statusBarView = UIView(frame: statusBarFrame)
            statusBarView.backgroundColor = Colors.black
            self.window?.addSubview(statusBarView)
        }
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark

        appCoordinator = AppCoordinator(navigationController)
        appCoordinator?.start()

        return true
    }
}
