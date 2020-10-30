//
//  ViewController.swift
//  VKClient
//
//  Created by Dzmitry on 10/28/20.
//

import Alamofire
import UIKit

class TableViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var tableView: UITableView!

    private let idCell = "Cell"
    private let service = Service()
    private var wall: ResponseWall = ResponseWall.empty()
    private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Wait a second, please", comment: "Pull to refresh")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.refreshControl = myRefreshControl
        myRefreshControl.beginRefreshing()
        downloadData()
    }

    @objc func refresh(sender _: UIRefreshControl) {
        downloadData()
    }

    /// Download ahd parse data.
    private func downloadData() {
        service.getWall { result in
            switch result {
            case let .success(data):
                self.wall = data
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

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return wall.response.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell,
                                                 for: indexPath) as? CustomTableViewCell

        // Configure the cell
        cell?.configure(wall.response.items[indexPath.row])
        return cell!
    }
}
