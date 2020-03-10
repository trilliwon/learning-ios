//
//  AppDelegate.swift
//  Homepwner
//
//  Created by WON on 06/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let itemStore = ItemStore()
        
        if let itemsController = window?.rootViewController as? ItemsViewController {
            itemsController.itemStore = itemStore
        }
        
        return true
    }
}
