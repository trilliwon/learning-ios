//
//  TabBarViewController.swift
//  Recoger
//
//  Created by won on 01/02/2018.
//  Copyright © 2018 Won. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let generatorView = GeneratorViewController.instance
        let recognizerView = RecognizerViewController.instance
        
        recognizerView.tabBarItem = UITabBarItem(title: "Recognizer", image: #imageLiteral(resourceName: "ml"), selectedImage: #imageLiteral(resourceName: "ml"))
        generatorView.tabBarItem = UITabBarItem(title: "generator", image: #imageLiteral(resourceName: "generator"), selectedImage:  #imageLiteral(resourceName: "generator"))
        
        setViewControllers([recognizerView, generatorView], animated: true)
    }
}
