//
//  LoginViewController+WebView.swift
//  VKClient
//
//  Created by Dzmitry on 11/9/20.
//

import WebKit

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
