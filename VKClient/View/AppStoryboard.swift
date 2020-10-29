//
//  AppStoryboard.swift
//  VKClient
//
//  Created by Dzmitry on 10/30/20.
//

import UIKit

/**
 Contains names of application storyboards and
 provide the ability to instantiate an appropriate view
 controller.
 */
enum AppStoryboard: String {
    case main = "Main"

    /**
     Gets a view controller of the specified type that
     is instantiated from the current storyboard.
     - Parameter viewController: Concrete
     type of the view controller to instantiate.
     - Returns: View controller with the type of
     input parameter `viewController` or `nil`
     if the view controller of the specified type couldn't
     be instantiated.
     */
    func viewController<T: UIViewController>(of viewController: T.Type) -> T? {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: viewController.storyboardID) as? T
    }
}

extension UIViewController {
    /**
     identifies the view controller in the storyboard file.
     */
    static var storyboardID: String {
        return "\(self)ID"
    }
}
