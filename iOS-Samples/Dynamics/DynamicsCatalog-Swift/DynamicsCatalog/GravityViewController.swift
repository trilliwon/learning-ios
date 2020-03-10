//
//  GravityViewController.swift
//  DynamicsCatalog
//
//  Created by won on 10/11/2018.
//  Copyright © 2018 won. All rights reserved.
//

import UIKit

class GravityViewController: UIViewController {

    @IBOutlet weak var square: UIImageView!
    var animator: UIDynamicAnimator?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animator = UIDynamicAnimator(referenceView: view)
        let gravityBehavior = UIGravityBehavior(items: [square])
        animator?.addBehavior(gravityBehavior)
    }
}
