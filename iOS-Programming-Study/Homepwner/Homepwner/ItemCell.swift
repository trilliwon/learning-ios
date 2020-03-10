//
//  ItemCell.swift
//  Homepwner
//
//  Created by USER on 07/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    /*
     The method awakeFromNib() gets called on an object after it is loaded from an archive,
     which in this case is the storyboard file.
     By the time this method is called, all of the outlets have values and can be used.
     */
    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
}
