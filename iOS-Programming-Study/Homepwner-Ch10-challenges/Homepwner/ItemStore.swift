//
//  ItemStore.swift
//  Homepwner
//
//  Created by WON on 06/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()

    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)

        allItems.append(newItem)

        return newItem
    }

    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
}
