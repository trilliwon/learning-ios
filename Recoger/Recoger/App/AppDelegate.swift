//
//  AppDelegate.swift
//  Recoger
//
//  Created by Won on 07/05/2017.
//  Copyright © 2017 Won. All rights reserved.
//

import UIKit

func appDelegate() -> AppDelegate {
    return UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        makeRootViewController(vc: TabBarViewController.instance)
		return true
	}
    
    func makeRootViewController(vc: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
