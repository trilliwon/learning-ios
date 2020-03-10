//
//  TimeSelectionViewController.swift
//  SettingView
//
//  Created by WON on 27/08/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit

class TimeSelectionViewController: UIViewController {

    // MARK: - private properties
    private let selectionFeedback = UISelectionFeedbackGenerator()
    private var currentInteractionController: UIPercentDrivenInteractiveTransition? = nil

    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private var bars = [UIView]()
    private var touchedBar: UIView?

    private var touchPosition: CGPoint? {
        didSet {
            guard let touched: (offSet: Int, bar: UIView) = bar(at: touchPosition) else {
                return
            }

            if touchedBar != touched.bar {
                selectionFeedback.selectionChanged()
            }

            touchedBar = touched.bar

            let aboveBars = bars[0...touched.offSet]
            let belowBars = bars[touched.offSet..<bars.count]

            aboveBars.forEach { $0.backgroundColor = UIColor.black.withAlphaComponent(0.7) }
            belowBars.forEach { $0.backgroundColor = UIColor.white }
        }
    }

    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentInteractionController?.finish()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:))))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureViews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stackView.removeFromSuperview()
    }

    // MARK: - Private Methods
    @objc private func viewTapped(_ gesture: UITapGestureRecognizer) {
        let touchedPoint = gesture.location(in: backgroundView)

        if !view.point(inside: touchedPoint, with: nil) {
            dismiss(animated: true)
        }
    }

    private func configureViews() {

        view.addSubview(backgroundView)

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: 120).isActive = true

        let addStackViewOnBackgroundView = { [weak self] in
            guard let `self` = self else {
                return
            }
            self.backgroundView.addSubview(self.stackView)
        }

        UIView.transition(with: view,
                          duration: 0.1,
                          options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: addStackViewOnBackgroundView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true

        bars.append(contentsOf: createBars(count: 20))
        bars.forEach {
            stackView.addArrangedSubview($0)
        }

        view.layoutIfNeeded()
    }

    private func bar(at point: CGPoint?) -> (Int, UIView)? {
        guard let point = point else { return nil }
        return Array(bars.enumerated()).first { _, bar -> Bool in
            let pointInAction = bar.convert(point, from: view)
            return bar.point(inside: pointInAction, with: nil)
        }
    }

    private func createBars(count: Int) -> [UIView] {
        var bars = [UIView]()

        (0..<count).forEach { _ in

            let line = UIView()
            line.backgroundColor = UIColor.lightGray

            let bar = UIView()
            bar.backgroundColor = UIColor.white

            bar.addSubview(line)

            line.translatesAutoresizingMaskIntoConstraints = false
            line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            line.bottomAnchor.constraint(equalTo: bar.bottomAnchor).isActive = true
            line.leadingAnchor.constraint(equalTo: bar.leadingAnchor).isActive = true
            line.trailingAnchor.constraint(equalTo: bar.trailingAnchor).isActive = true

            bar.translatesAutoresizingMaskIntoConstraints = false
            bar.heightAnchor.constraint(equalToConstant: 20).isActive = true

            bars.append(bar)
        }

        return bars
    }
}


// MARK: - touches
extension TimeSelectionViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchPosition = touch.location(in: view)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchPosition = touch.location(in: view)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchPosition = touch.location(in: view)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchPosition = touch.location(in: view)
        }
    }
}

extension TimeSelectionViewController: UIViewControllerTransitioningDelegate {

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        currentInteractionController = UIPercentDrivenInteractiveTransition()
        return currentInteractionController
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }

    // MARK: - Animators
    class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.2
        }

        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            let animations: () -> Void = {
                if let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                    transitionContext.containerView.addSubview(toView)
                    toView.layoutIfNeeded()
                    toView.alpha = 1.0
                }
            }

            let completion: (Bool) -> Void = { finished in
                transitionContext.completeTransition(finished)
            }

            UIView.animate(withDuration: 0.2, delay: 0, animations: animations, completion: completion)
        }
    }

    class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {

        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.2
        }

        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            let animations: () -> Void = {
                let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
                fromViewController?.view.alpha = 0.0
            }

            let completion: (Bool) -> Void = { finished in
                transitionContext.completeTransition(true)
            }

            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: animations, completion: completion)
        }
    }


    // MARK: - UIPresentationController
    class PresentationController: UIPresentationController {

        private let blurView = UIVisualEffectView()

        override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
            super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
            blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }

        override func presentationTransitionWillBegin() {
            guard let containerView = containerView else {
                return
            }

            blurView.frame = containerView.bounds
            containerView.insertSubview(blurView, at: 0)

            let blurAnimation: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = { _ in
                self.blurView.effect = UIBlurEffect(style: .light)
            }

            presentedViewController.transitionCoordinator?.animate(alongsideTransition: blurAnimation)
        }

        override func dismissalTransitionWillBegin() {
            let blurAnimation: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = { _ in
                self.blurView.effect = nil
            }
            presentedViewController.transitionCoordinator?.animate(alongsideTransition: blurAnimation)
        }

        override var frameOfPresentedViewInContainerView: CGRect {
            return containerView?.bounds ?? CGRect.zero
        }
    }
}
