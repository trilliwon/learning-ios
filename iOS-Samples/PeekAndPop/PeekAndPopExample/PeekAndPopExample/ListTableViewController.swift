//
//  ListTableViewController.swift
//  PeekAndPopExample
//
//  Created by WON on 18/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    fileprivate let peekedViewController = PeekAndPopController()
    let dataSource = ["Hello", "Hi", "Good morning", "Good Evening", "Weapoon"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        registerForPreviewing(with: self, sourceView: view)

        let download = PeekAndPopActionView(text: "Download", image: #imageLiteral(resourceName: "btnDownload"), handler: {
            print("Download Action")
        })

        let playNext = PeekAndPopActionView(text: "Play Next", image: #imageLiteral(resourceName: "btnDownload"), handler: {
            print("Play Next Action")
        })

        let playLast = PeekAndPopActionView(text: "Play Later", image: #imageLiteral(resourceName: "btnDownload"), handler: {
            print("Play Last Action")
        })

        let share = PeekAndPopActionView(text: "Share", image: #imageLiteral(resourceName: "btnDownload"), handler: {
            print("Share Action")
        })

        peekedViewController.addAction(download)
        peekedViewController.addAction(playNext)
        peekedViewController.addAction(playLast)
        peekedViewController.addAction(share)
        peekedViewController.topView = TopView().loadNib()

        peekedViewController.topView?.handler = {
            print("Play Play Play")
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}

extension ListTableViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return nil
        }
        print(#function, indexPath)
        return peekedViewController
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(peekedViewController, sender: self)
    }


}
