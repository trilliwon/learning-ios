//
//  ShineLabel.swift
//  ShineLabel
//
//  Created by won on 10/11/2018.
//  Copyright © 2018 won. All rights reserved.
//

import UIKit

class ShineLabel: UILabel {

    var shineDuration: CFTimeInterval = 0
    var fadeoutDuration: CFTimeInterval = 0

    var isAutoStart: Bool = false

    var isShining: Bool {
        return !displaylink.isPaused
    }

    var isVisible: Bool {
        return !isFadeOut
    }

    private var attributedString: NSMutableAttributedString?

    private var characterAnimationDurtions = [CFTimeInterval]()
    private var characterAnimationDelays = [CFTimeInterval]()

    private var displaylink: CADisplayLink!
    private var beginTime: CFTimeInterval = 0
    private var endTime: CFTimeInterval = 0
    private var isFadeOut: Bool
    private var completion: (() -> Void)?

    override var text: String? {
        set {
            super.text = newValue
            attributedText = NSMutableAttributedString(string: newValue!)
        }

        get {
            return super.text
        }
    }

    override var attributedText: NSAttributedString? {
        set {
            guard let newValue = newValue as? NSMutableAttributedString else {
                return
            }

            let length = newValue.length
            let color = textColor.withAlphaComponent(0)
            newValue.addAttributes([.foregroundColor : color], range: NSRange(location: 0, length: length))
            attributedString = newValue

            super.attributedText = newValue

            characterAnimationDelays = Array(repeating: 0.0, count: length)
            characterAnimationDurtions = Array(repeating: 0.0, count: length)

            for index in 0..<newValue.length {

                let delay = Double.random(in: 0..<shineDuration / 2 * 100) / 100.0
                characterAnimationDelays[index] = delay
                let remain = shineDuration - delay
                characterAnimationDurtions[index] = Double.random(in: 0..<remain * 100) / 100.0
            }
        }

        get {
            return super.attributedText
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        shineDuration = 2.5
        fadeoutDuration = 2.5
        isAutoStart = false
        isFadeOut = true

        super.init(frame: frame)

        textColor = UIColor.white
        displaylink = CADisplayLink(target: self, selector: #selector(updateAttributedString))
        displaylink.isPaused = true
        displaylink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if self.window != nil && isAutoStart {
            shine()
        }
    }

    @objc
    private func updateAttributedString() {
        guard let attributedString = attributedString else {
            return
        }

        let now = CACurrentMediaTime()
        for index in 0..<attributedString.length {

            let range = NSRange(location: index, length: 1)
            attributedString.enumerateAttribute(.foregroundColor, in: range, options: .longestEffectiveRangeNotRequired) { value, range, _ in

                let currentAlpha = (value as? UIColor)!.cgColor.alpha
                let checkAlpha = (isFadeOut && (currentAlpha > 0.0)) || (!isFadeOut && (currentAlpha < 1))

                guard checkAlpha || (now - beginTime) >= characterAnimationDelays[index] else {
                    return
                }

                var percentage = (now - beginTime - characterAnimationDelays[index]) / characterAnimationDurtions[index]
                if isFadeOut {
                    percentage = 1 - percentage
                }

                let color = textColor.withAlphaComponent(CGFloat(percentage))
                attributedString.addAttributes([.foregroundColor : color], range: range)
            }
        }

        super.attributedText = attributedString

        if now > endTime {
            displaylink.isPaused = true
            if completion != nil {
                completion?()
            }
        }
    }

    private func startAnimation(with duration: CFTimeInterval) {
        beginTime = CACurrentMediaTime()
        endTime = beginTime + shineDuration
        displaylink.isPaused = false
    }

    func shine(_ completion: (() -> Void)? = nil) {
        if !isShining && isFadeOut {
            self.completion = completion
            isFadeOut = false
            startAnimation(with: fadeoutDuration)
        }
    }

    func fadeOut(_ completion: (() -> Void)? = nil) {
        if !isShining && !isFadeOut {
            self.completion = completion
            isFadeOut = true
            startAnimation(with: fadeoutDuration)
        }
    }
}
