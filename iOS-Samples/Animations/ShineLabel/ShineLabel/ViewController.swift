//
//  ViewController.swift
//  ShineLabel
//
//  Created by won on 10/11/2018.
//  Copyright © 2018 won. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let shineLabel: ShineLabel = {
//        let shineLabel = ShineLabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
        shineLabel.numberOfLines = 3
        shineLabel.text = "Professionals takes risks \non what they know what must be done."
        shineLabel.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        shineLabel.textColor = UIColor.white
        shineLabel.textAlignment = .center
        shineLabel.sizeToFit()
        return shineLabel
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.view.addSubview(shineLabel)
        shineLabel.center = view.center
    }

    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        print(shineLabel.isVisible)
        if shineLabel.isVisible {
            shineLabel.fadeOut()
        } else {
            shineLabel.shine()
        }
    }
}
