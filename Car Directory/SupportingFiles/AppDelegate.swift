//
//  AppDelegate.swift
//  Car Directory
//
//  Created by Timur Rakhimov on 07/10/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.isAppAlreadyLaunchedOnce()
        self.createRootViewController()
        return true
    }

    private func createRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = CarsListViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        self.window?.makeKeyAndVisible()
    }

    @discardableResult
    private func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            Car.createExampleCars()
            return false
        }
    }

}

