//
//  ViewController.swift
//  SettingView
//
//  Created by WON on 27/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerButton: UIButton!

    @IBAction func timerButtonTapped(_ sender: UIButton) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let forceTouch = ForceTouchGestureRecognizer(target: self, action: #selector(handleForceTouch(_:)))
        timerButton.addGestureRecognizer(forceTouch)
    }

    @objc func handleForceTouch(_ gesture: ForceTouchGestureRecognizer) {
        print(#function)
        present(TimeSelectionViewController(), animated: true)
    }
}
