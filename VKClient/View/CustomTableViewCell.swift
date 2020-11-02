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

    func configure(_ itemsWithNames: ItemsWithName) {
        if let firstName = itemsWithNames.firstName,
            let lastName = itemsWithNames.lastName {
            fullName.text = firstName + " " + lastName
        } else { fullName.text = "No name" }
        wallText.text = itemsWithNames.text
    }
}
