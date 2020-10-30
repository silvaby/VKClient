//
//  CustomTableViewCell.swift
//  VKClient
//
//  Created by Dzmitry on 10/28/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var fullName: UILabel!
    @IBOutlet var wallText: UILabel!

    func configure(_ item: Item) {
        if let wallText = item.text {
            self.wallText.text = wallText
        } else { wallText.text = "No name" }
    }

    func configure(_ profile: Profile) {
        if let name = profile.firstName {
            fullName.text = name
        } else { fullName.text = "No name" }
    }
}
