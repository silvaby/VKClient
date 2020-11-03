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

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7643520"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.124"),
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
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

extension LoginViewController: WKNavigationDelegate {
    func webView(_: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
            let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        guard let token = params["access_token"], let userId = params["user_id"] else {
            let alert = UIAlertController(title: "Error",
                                          message: "Authorization error",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)

            return
        }

        Session.instance.token = token
        Session.instance.userId = userId

        // Save to UserDefaults
        UserDefaults.standard.setValue(token, forKey: "Token")
        UserDefaults.standard.setValue(userId, forKey: "UserId")

        decisionHandler(.cancel)

        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
}
