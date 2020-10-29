//
//  SettingsViewController.swift
//  VKClient
//
//  Created by Dzmitry on 10/28/20.
//

import Alamofire
import SDWebImage
import UIKit
import WebKit

class SettingsViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var photo: UIImageView!
    @IBOutlet var firstName: UILabel!

    private let service = Service()
    private var users = [Users]()

    override func viewDidLoad() {
        super.viewDidLoad()

        downloadData()
    }

    /// Download ahd parse data.
    private func downloadData() {
        service.getUser { result in
            switch result {
            case let .success(data):
                self.users = data
                self.firstName.text = self.users.first?.response.first?.firstName ?? "No name"

                if let imageURL = self.users.first?.response.first?.photoMax {
                    let url = URL(string: imageURL)
                    self.photo.sd_setImage(with: url,
                                           placeholderImage: #imageLiteral(resourceName: "VKLogo"),
                                           options: .scaleDownLargeImages,
                                           completed: nil)
                }

                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - TODO

    @IBAction func logout(_: Any) {
        // VKSdk.forceLogout()
        Session.instance.token = ""
        Session.instance.userId = ""

//        let logoutUrl = "https://api.vk.com/oauth/logout"
//
//        let request = NSMutableURLRequest(url: NSURL(string: logoutUrl)! as URL,
//                                          cachePolicy: .reloadIgnoringLocalCacheData,
//                                          timeoutInterval: 60.0)
//        let responseData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)

//        let storage = HTTPCookieStorage.shared
//        for cookie in storage.cookies! {
//            let domainName = cookie.domain
//            let domainRange = domainName.range(of: "vk.com")
//
//            storage.deleteCookie(cookie)
//        }

//        let dataStore = WKWebsiteDataStore.default()
//        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
//          dataStore.removeData(
//            ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
//            for: records.filter { $0.displayName.contains("vk") }, completionHandler: () -> Void
//          )
//        }
    }
}
