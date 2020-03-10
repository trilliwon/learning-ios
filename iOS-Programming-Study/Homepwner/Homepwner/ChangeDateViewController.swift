//
//  ChangeDateViewController.swift
//  Homepwner
//
//  Created by USER on 16/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

class ChangeDateViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }

    @IBAction func dateChanged(_ sender: UIDatePicker) {
        item.dateCreated = sender.date
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = item.dateCreated
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
}
