//
//  AppDelegate.swift
//  VKClient
//
//  Created by Dzmitry on 10/28/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _:
        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let viewController: UIViewController?

        if UserDefaults.standard.string(forKey: "Token") != nil, UserDefaults.standard.string(forKey: "Id") != nil {
            viewController = AppStoryboard.main.viewController(of: SettingsViewController.self)
        } else {
            viewController = AppStoryboard.main.viewController(of: LoginViewController.self)
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}
