//
//  ForceTouchGestureRecognizer.swift
//  SettingView
//
//  Created by WON on 27/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

final class ForceTouchGestureRecognizer: UIGestureRecognizer {

    let impact = UINotificationFeedbackGenerator()

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = UIGestureRecognizer.State.failed
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        state = UIGestureRecognizer.State.failed
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if let firstTouch = touches.first {
            handleTouch(firstTouch)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if let firstTouch = touches.first {
            handleTouch(firstTouch)
        }
    }

    func handleTouch(_ firstTouch: UITouch) {
        guard firstTouch.force != 0 && firstTouch.maximumPossibleForce != 0 else {
            return
        }

        let threshold: CGFloat = 0.7

        if firstTouch.force / firstTouch.maximumPossibleForce >= threshold {
            state = UIGestureRecognizer.State.recognized
            impact.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
        }
    }
}

