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
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        viewController = storyboard.instantiateViewController(withIdentifier:
//            "SettingsViewControllerID")
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = viewController
//        window?.makeKeyAndVisible()

        // Check
        if Authentication.isSignedIn {
            // Going to SettingsViewController
            navigateToSettingsVC()
            print("Going to SettingsViewController")
        } else {
            // Going to LoginViewController
            navigateToLoginVC()
            print("LoginViewController")
        }

        return true
    }

    private func navigateToSettingsVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "SettingsViewControllerID") as? SettingsViewController else { return }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNavigationVC
        window?.makeKeyAndVisible()
    }

    private func navigateToLoginVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewControllerID") as? LoginViewController else { return }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNavigationVC
        window?.makeKeyAndVisible()
    }
}
