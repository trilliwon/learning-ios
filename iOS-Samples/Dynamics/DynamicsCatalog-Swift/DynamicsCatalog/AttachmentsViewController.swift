//
//  AttachmentsViewController.swift
//  DynamicsCatalog
//
//  Created by won on 10/11/2018.
//  Copyright © 2018 won. All rights reserved.
//

import UIKit

class AttachmentsViewController: UIViewController {

    @IBOutlet weak var squareAttachmentView: UIImageView!
    @IBOutlet weak var attachmentView: UIImageView!
    @IBOutlet weak var square: UIView!

    var animator: UIDynamicAnimator?
    var attachmentBehavior: UIAttachmentBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: view)
        let collisionBehavior = UICollisionBehavior(items: [square])
        // Creates collision boundaries from the bounds of the dynamic animator's
        // reference view (self.view).
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collisionBehavior)

        let squareCenterPoint = CGPoint(x: square.center.x, y: square.center.y - 110.0)
        let attachmentPoint = UIOffset(horizontal: -25.0, vertical: -25.0)

        // By default, an attachment behavior uses the center of a view. By using a
        // small offset, we get a more interesting effect which will cause the view
        // to have rotation movement when dragging the attachment.
        attachmentBehavior = UIAttachmentBehavior(item: square,
                                                  offsetFromCenter: attachmentPoint,
                                                  attachedToAnchor: squareCenterPoint)
        if let attachmentBehavior = attachmentBehavior {
            animator?.addBehavior(attachmentBehavior)
            // Visually show the attachment points
            attachmentView.center = attachmentBehavior.anchorPoint
        }

        attachmentView.tintColor = UIColor.red
        attachmentView.image = attachmentView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.squareAttachmentView.center = CGPoint(x: 25.0, y: 25.0)
        self.squareAttachmentView.tintColor = UIColor.blue
        self.squareAttachmentView.image = self.squareAttachmentView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)

        // Visually show the connection between the attachment points.
        (view as? DecorationView)?.trackAndDrawAttachmentFromView(attachmentPointView: attachmentView,
                                                                  attachedView: square,
                                                                  attachmentOffset: CGPoint(x: -25.0, y: -25.0))
    }
    
    @IBAction func handleAttachmentGesture(_ sender: UIPanGestureRecognizer) {
        attachmentBehavior?.anchorPoint = sender.location(in: view)
        attachmentView.center = sender.location(in: view)
    }
}
