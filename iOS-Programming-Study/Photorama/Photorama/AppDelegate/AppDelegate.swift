//
//  AppDelegate.swift
//  Photorama
//
//  Created by USER on 10/08/2018.
//  Copyright © 2018 trilliwon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let rootViewController = window!.rootViewController as! UINavigationController
        let photosViewController =
            rootViewController.topViewController as! PhotosViewController
        photosViewController.store = PhotoStore()
        return true
    }
}

