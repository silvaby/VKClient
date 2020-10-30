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
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - TODO

    @IBAction func logout(_: Any) {}
}
