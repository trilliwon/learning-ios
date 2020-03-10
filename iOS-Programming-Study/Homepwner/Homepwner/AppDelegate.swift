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
    let itemStore = ItemStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let imageStore = ImageStore()

        guard let navController = window!.rootViewController as? UINavigationController else {
            return true
        }

        guard let itemsController = navController.topViewController as? ItemsViewController else {
            return true
        }

        itemsController.itemStore = itemStore
        itemsController.imageStore = imageStore
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        let success = itemStore.saveChanges()
        if success {
            print("Saved al of the items")
        } else {
            print("Could not save any of the items")
        }
    }
}
