//
//  DecorationView.swift
//  DynamicsCatalog
//
//  Created by won on 10/11/2018.
//  Copyright © 2018 won. All rights reserved.
//

import UIKit

class DecorationView: UIView {

    var attachmentPointView: UIView?
    var attachedView: UIView?
    var attachmentOffset: CGPoint?

    //! Array of CALayer objects, each with the contents of an image
    //! for a dash.
    var attachmentDecorationLayers: [CALayer] = []
    @IBOutlet weak var centerPointView: UIImageView!
    var arrowView: UIImageView?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundTile")!)
    }

    func drawMagnitudeVectorWithLength(length: CGFloat, angle: CGFloat, arrowColor: UIColor, temporary: Bool) {
        if self.arrowView == nil {
            let arrowImage = UIImage(named: "Arrow")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            let arrowImageView = UIImageView(image: arrowImage)

            arrowImageView.bounds = CGRect(x: 0, y: 0, width: arrowImage.size.width, height: arrowImage.size.height)
            arrowImageView.contentMode = .right
            arrowImageView.clipsToBounds = true
            arrowImageView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)

            addSubview(arrowImageView)
            sendSubviewToBack(arrowImageView)
            self.arrowView = arrowImageView
        }

        guard let arrowView = arrowView else {
            return
        }

        arrowView.bounds = CGRect(x: 0, y: 0, width: length, height: arrowView.bounds.size.height)
        arrowView.transform = CGAffineTransform(rotationAngle: angle)
        arrowView.tintColor = arrowColor
        arrowView.alpha = 1

        if temporary {
            UIView.animate(withDuration: 1.0) {
                arrowView.alpha = 0
            }
        }
    }

    deinit {
        attachmentPointView?.removeObserver(self, forKeyPath: "center")
        attachedView?.removeObserver(self, forKeyPath: "center")
    }

    func trackAndDrawAttachmentFromView(attachmentPointView: UIView, attachedView: UIView, attachmentOffset: CGPoint) {

        if attachmentDecorationLayers.isEmpty {
            for i in 0..<4 {

                let dashImage = UIImage(named: String(format: "DashStyle%i", (i % 3) + 1))!
                let dashLayer = CALayer()
                dashLayer.contents = dashImage.cgImage
                dashLayer.bounds = CGRect(x: 0, y: 0, width: dashImage.size.width, height: dashImage.size.height)
                dashLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
                layer.insertSublayer(dashLayer, at: 0)
                attachmentDecorationLayers.append(dashLayer)
            }
        }

        // A word about performance.
        // Tracking changes to the properties of any id<UIDynamicItem> involved in
        // a simulation incurs a performance cost.  You will receive a callback
        // during each step in the simulation in which the tracked item is not at
        // rest.  You should therefore strive to make your callback code as
        // efficient as possible.
        self.attachmentPointView = attachmentPointView
        self.attachedView = attachedView
        self.attachmentOffset = attachmentOffset

        // Observe the 'center' property of both views to know when they move.
        self.attachmentPointView?.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.new, context: nil)
        self.attachedView?.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.new, context: nil)

        self.setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.arrowView?.center = CGPoint(x: bounds.midX, y: bounds.midY)

        if let centerPointView = centerPointView {
            centerPointView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        }

        guard
            let attachmentPointView = attachmentPointView,
            let attachedView = attachedView,
            let attachmentOffset = attachmentOffset else {
            return
        }

        // Here we adjust the line dash pattern visualizing the attachement
        // between attachmentPointView and attachedView to account for a change
        // in the position of either.

        var attachmentPointViewCenter = CGPoint(x: attachmentPointView.bounds.size.width / 2,
                                                y: attachmentPointView.bounds.size.height / 2)
        attachmentPointViewCenter = attachmentPointView.convert(attachmentPointViewCenter, to: self)

        var attachedViewAttachmentPoint = CGPoint(x: attachedView.bounds.size.width / 2 + attachmentOffset.x,
                                                  y: attachedView.bounds.size.height / 2 + attachmentOffset.y)
        attachedViewAttachmentPoint = attachedView.convert(attachedViewAttachmentPoint, to: self)

        let distance: CGFloat = CGFloat(sqrtf(
            powf(Float(attachedViewAttachmentPoint.x - attachmentPointViewCenter.x), 2.0) +
                powf(Float(attachedViewAttachmentPoint.y - attachmentPointViewCenter.y), 2.0)
        ))

        let angle = atan2(attachedViewAttachmentPoint.y-attachmentPointViewCenter.y,
                          attachedViewAttachmentPoint.x-attachmentPointViewCenter.x );

        var d: CGFloat = 0.0
        let maxDashes = attachmentDecorationLayers.count
        var requiredDashes = 0

        while requiredDashes < maxDashes {
            let dashLayer = attachmentDecorationLayers[requiredDashes]
            if d + dashLayer.bounds.size.height < distance {
                d += dashLayer.bounds.size.height
                dashLayer.isHidden = false
                requiredDashes += 1
            } else {
                break
            }
        }

        // Based on the total length of the dashes we previously determined were
        // necessary to visualize the attachment, determine the spacing between
        // each dash.
        let dashSpacing = (distance - d) / CGFloat(requiredDashes + 1)

        // Hide the excess dashes.

        while requiredDashes < maxDashes {
            attachmentDecorationLayers[requiredDashes].isHidden = true
            requiredDashes += 1
        }

        // Disable any animations.  The changes must take full effect immediately.
        CATransaction.begin()
        CATransaction.setAnimationDuration(0)

        // Each dash layer is positioned by altering its affineTransform.  We
        // combine the position of rotation into an affine transformation matrix
        // that is assigned to each dash.

        var transform = CGAffineTransform().translatedBy(x: attachmentPointViewCenter.x, y: attachmentPointViewCenter.y)
        transform = transform.rotated(by: angle - CGFloat(Double.pi / 2.0))

        for drawnDashes in 0..<requiredDashes {
            let dashLayer = attachmentDecorationLayers[drawnDashes]
            transform = transform.translatedBy(x: 0, y: dashSpacing)
            dashLayer.setAffineTransform(transform)
            transform = transform.translatedBy(x: 0, y: dashLayer.bounds.size.height)
        }

        CATransaction.commit()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as? UIView == self.attachmentPointView || object as? UIView == self.attachedView {
            setNeedsLayout()
        } else {
            observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
