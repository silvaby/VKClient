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
        // Going to SettingsViewController
//        var viewController: UIViewController?
//        if UserDefaults.standard.string(forKey: "Token") != nil,
//            UserDefaults.standard.string(forKey: "Id") != nil {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            viewController = storyboard.instantiateViewController(withIdentifier:
//                "SettingsViewControllerID")
//            window = UIWindow(frame: UIScreen.main.bounds)
//            window?.rootViewController = viewController
//            window?.makeKeyAndVisible()
//        }
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = viewController
//        window?.makeKeyAndVisible()

        // Check
//        if Authentication.isSignedIn {
//            // Go to SettingsViewController
//        } else {
//            // Go to LoginViewController
//        }
        return true
    }
}
