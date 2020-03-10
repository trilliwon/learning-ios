//
//  ViewController.swift
//  Buggy
//
//  Created by USER on 02/08/2018.
//  Copyright © 2018 trilliwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func badMethod() {
        let array = NSMutableArray()

        for i in 0..<10 {
            array.insert(i, at: i)
        }

        // Go one step too far emptying the array
        for _ in 0..<10 {
            array.removeObject(at: 0)
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Method: \(#function) in file: \(#file) line: \(#line) called.")
        badMethod()
    }
}
