//
//  SettingsViewController.swift
//  VKClient
//
//  Created by Dzmitry on 10/28/20.
//

import Alamofire
import SDWebImage
import UIKit

class SettingsViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var photo: UIImageView!
    @IBOutlet var firstName: UILabel!

    private let service = Service()

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()

        Authentication.signIn { _ in }
        print("Now isSignedIn: ", Authentication.isSignedIn)
    }

    /// Download and parse data.
    private func downloadData() {
        service.getUser { result in
            switch result {
            case let .success(data):
                self.service.parseUsers(jsonData: data)
                if let firstName = self.service.users.response.first?.firstName,
                    let lastName = self.service.users.response.first?.lastName {
                    self.firstName.text = firstName + " " + lastName
                }
                if let imageURL = self.service.users.response.first?.photoMax {
                    let url = URL(string: imageURL)
                    self.photo.sd_setImage(with: url,
                                           placeholderImage: #imageLiteral(resourceName: "VKLogo"),
                                           options: .scaleDownLargeImages,
                                           completed: nil)
                }

            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - Logout button

    @IBAction func logout(_: Any) {
        WebCacheCleaner.clean()
        Authentication.signOut { _ in }
        print("Now isSignedIn: ", Authentication.isSignedIn)
    }
}
