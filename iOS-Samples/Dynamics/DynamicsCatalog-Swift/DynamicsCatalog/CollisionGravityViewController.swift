//
//  CollisionGravityViewController.swift
//  DynamicsCatalog
//
//  Created by won on 10/11/2018.
//  Copyright © 2018 won. All rights reserved.
//

import UIKit

class CollisionGravityViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var square: UIImageView!
    var animator: UIDynamicAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        square.image = square.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        square.tintColor = UIColor.darkGray
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animator = UIDynamicAnimator(referenceView: view)
        let gravityBehavior = UIGravityBehavior(items: [square])
        let collisionBehavior = UICollisionBehavior(items: [square])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self

        animator?.addBehavior(gravityBehavior)
        animator?.addBehavior(collisionBehavior)
    }

    //  This method is called when square begins contacting a collision boundary.
    //  In this demo, the only collision boundary is the bounds of the reference
    //  view (self.view).
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        (item as? UIView)?.tintColor = UIColor.lightGray
    }

    //  This method is called when square stops contacting a collision boundary.
    //  In this demo, the only collision boundary is the bounds of the reference
    //  view (self.view).
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        (item as? UIView)?.tintColor = UIColor.darkGray
    }
}

