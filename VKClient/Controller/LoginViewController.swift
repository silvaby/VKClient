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

        print(urlComponents)
        let request = URLRequest(url: urlComponents.url!)

        webView.load(request)
    }
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("webView now is here")
        print(navigationResponse.response.url!)

        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
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

        print("token: " + params["access_token"]!)
        print("id: " + params["user_id"]!)

        Session.instance.token = params["access_token"]!
        Session.instance.userId = params["user_id"]!

        // Save to UserDefaults
        UserDefaults.standard.setValue(params["access_token"]!, forKey: "Token")
        UserDefaults.standard.setValue(params["user_id"]!, forKey: "Id")

        decisionHandler(.cancel)

        performSegue(withIdentifier: "Login Segue", sender: nil)
    }
}
