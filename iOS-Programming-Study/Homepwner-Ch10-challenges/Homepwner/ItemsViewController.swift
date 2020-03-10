//
//  ViewController.swift
//  Homepwner
//
//  Created by WON on 06/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    var itemStore: ItemStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height

        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets

        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "tableviewbg.jpg"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return itemStore.allItems.filter({ $0.valueInDollars > 50 }).count
        } else if section == 1 {
            return itemStore.allItems.filter({ $0.valueInDollars <= 50 }).count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.7)

        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview

        let item : Item
        if indexPath.section == 0 {
            item = itemStore.allItems.filter({ $0.valueInDollars > 50 })[indexPath.row]
            cell.textLabel?.font = cell.textLabel?.font.withSize(20)
        } else if indexPath.section == 1 {
            item = itemStore.allItems.filter({ $0.valueInDollars <= 50 })[indexPath.row]
            cell.textLabel?.font = cell.textLabel?.font.withSize(20)
        } else {
            item = Item(name: "No more items!", serialNumber: nil, valueInDollars: 0)
        }

        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.valueInDollars == 0 ? "" : "$\(item.valueInDollars)"

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 44
        }
        return 60
    }
}

