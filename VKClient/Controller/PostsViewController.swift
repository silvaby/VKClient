//
//  ViewController.swift
//  VKClient
//
//  Created by Dzmitry on 10/28/20.
//

import Alamofire
import UIKit

class PostsViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var tableView: UITableView!

    private let service = Service()
    private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Wait a second, please",
                                      comment: "Pull to refresh")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self,
                                 action: #selector(refresh(sender:)),
                                 for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.refreshControl = myRefreshControl
        myRefreshControl.beginRefreshing()
        downloadData()
    }

    @objc func refresh(sender _: UIRefreshControl) {
        downloadData()
    }

    /// Download and parse data.
    private func downloadData() {
        service.getWall { result in
            switch result {
            case let .success(data):
                self.service.parseWall(jsonData: data)
            case let .failure(error):
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }
}

// MARK: - Create and configure table

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return service.itemsWithNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.postsCellID,
                                                 for: indexPath) as? CustomTableViewCell
        // Configure the cell
        cell?.configure(service.itemsWithNames[indexPath.row])
        return cell!
    }
}
