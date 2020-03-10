//
//  LangTableViewController.swift
//  SwipeActionExample
//
//  Created by WON on 26/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

struct Lang {
    let title: String
    let image: UIImage
    var liked = false

    init(_ title: String, _ image: UIImage) {
        self.title = title
        self.image = image
    }
}

class LangTableViewController: UITableViewController {

    var langs = [
        Lang("Swift", #imageLiteral(resourceName: "swift")),
        Lang("C++", #imageLiteral(resourceName: "cpp")),
        Lang("Java", #imageLiteral(resourceName: "java")),
        Lang("Python", #imageLiteral(resourceName: "python")),
        Lang("Scala", #imageLiteral(resourceName: "scala")),
        Lang("Haskell", #imageLiteral(resourceName: "haskell")),
        Lang("Racket", #imageLiteral(resourceName: "racket"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = false
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let share = UIContextualAction(style: .normal, title: "Share") { action, view, completion in
            completion(true)
        }

        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
            self?.langs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            completion(true)
        }

        delete.image = #imageLiteral(resourceName: "trash")

        return UISwipeActionsConfiguration(actions: [delete, share])
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let like = UIContextualAction(style: .normal, title: "Like") { [weak self] action, view, completion in
            guard let `self` = self else {
                return
            }
            self.langs[indexPath.row].liked = !self.langs[indexPath.row].liked
            completion(true)
        }

        like.image = langs[indexPath.row].liked ? #imageLiteral(resourceName: "filledLike") : #imageLiteral(resourceName: "like")
        like.backgroundColor = UIColor.darkGray

        return UISwipeActionsConfiguration(actions: [like])
    }

   // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = langs[indexPath.row].title
        cell.imageView?.frame.size = CGSize(width: 30, height: 30)
        cell.imageView?.image = langs[indexPath.row].image
        return cell
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        langs.insert(langs.remove(at: fromIndexPath.row) , at: to.row)
    }
}
