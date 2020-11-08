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
        load()
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

    private func load() {
        var urlComponents = URLComponents()
        urlComponents.scheme = Keys.requestScheme
        urlComponents.host = Keys.requestHost
        urlComponents.path = Keys.requestPath
        urlComponents.queryItems = [
            URLQueryItem(name: Keys.requestClientIdKey,
                         value: Keys.requestClientIdValue),
            URLQueryItem(name: Keys.requestDisplayKey,
                         value: Keys.requestDisplayValue),
            URLQueryItem(name: Keys.requestRedirectUriKey,
                         value: Keys.requestRedirectUriValue),
            URLQueryItem(name: Keys.requestScopeKey,
                         value: Keys.requestScopeValue),
            URLQueryItem(name: Keys.requestResponseTypeKey,
                         value: Keys.requestResponseTypeValue),
            URLQueryItem(name: Keys.versionKey, value: Keys.versionValue),
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == Keys.responsePath,
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

        guard let token = params[Keys.accessTokenKey],
            let userId = params[Keys.userIdKey] else {
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
        UserDefaults.standard.setValue(token, forKey: Keys.userDefaultsAccessTokenKey)
        UserDefaults.standard.setValue(userId, forKey: Keys.userDefaultsUserIdKey)

        decisionHandler(.cancel)

        performSegue(withIdentifier: Keys.loginSegueID, sender: nil)
    }
}
