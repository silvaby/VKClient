//
//  LoginViewController.swift
//  VKClient
//
//  Created by Dzmitry on 10/29/20.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Service.loadContent(in: webView)
    }

    // Alert "No Internet"
    override func viewDidAppear(_: Bool) {
        if Reachability.isConnectedToNetwork() {
            print("Internet Connection Available!")
        } else {
            print("Internet Connection not Available!")
            let controller = UIAlertController(title: "No Internet Detected",
                                               message: "This app requires an Internet connection",
                                               preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            controller.addAction(ok)
            controller.addAction(cancel)
            present(controller, animated: true, completion: nil)
        }
    }
}
