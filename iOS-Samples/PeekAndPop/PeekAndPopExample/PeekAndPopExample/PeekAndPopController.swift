import UIKit

class PeekAndPopController: UIViewController {

    /// MARK: - Properties
    var actions: [PeekAndPopAction] = []

    private var currentInteractionController: UIPercentDrivenInteractiveTransition? = nil
    var interactiveTransitionProgress: CGFloat = 0.0 {
        didSet {
            currentInteractionController?.update(interactiveTransitionProgress)
        }
    }

    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    var topView: PeekAndPopAction? {
        didSet {
            guard let topView = topView else {
                return
            }

            if let oldValue = oldValue {
                stackView.removeArrangedSubview(oldValue)
            }

            topView.translatesAutoresizingMaskIntoConstraints = false
            stackView.insertArrangedSubview(topView, at: 0)
            let priority = UILayoutPriority(topView.contentHuggingPriority(for: .vertical).rawValue - 1)
            topView.setContentHuggingPriority(priority, for: .vertical)
            topView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            actions.append(topView)
            view.layoutIfNeeded()
        }
    }

    var previewTouchPosition: CGPoint? {
        didSet {
            let touchedAction = action(at: previewTouchPosition)
            touchedAction?.isHighlighted = true
            let untouchedActions = actions.filter { action -> Bool in
                return action != touchedAction
            }
            for untouchedAction in untouchedActions {
                untouchedAction.isHighlighted = false
            }
        }
    }

    private func action(at point: CGPoint?) -> PeekAndPopAction? {
        guard let point = point else { return nil }
        return actions.first { action -> Bool in
            let pointInAction = action.convert(point, from: view)
            return action.point(inside: pointInAction, with: nil)
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
        completeCurrentInteractiveTransition()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureViews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stackView.removeFromSuperview()
    }

    // MARK: - Methods
    func configureViews() {
        view.addSubview(backgroundView)

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true

        backgroundView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        view.layoutIfNeeded()
    }

    func addAction(_ action: PeekAndPopActionView) {
        stackView.addArrangedSubview(action)
        actions.append(action)
        view.layoutIfNeeded()
    }

    func chooseTouchedAction() {
        guard let touchedAction = action(at: previewTouchPosition) else {
            return
        }
        touchedAction.handler?()
        touchedAction.isHighlighted = false
    }

    @objc func viewTapped() {
        dismiss(animated: true)
    }

    func completeCurrentInteractiveTransition() {
        currentInteractionController?.finish()
    }

    func cancelCurrentInteractiveTransition() {
        currentInteractionController?.cancel()
    }
}

// MARK: - touches
extension PeekAndPopController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            previewTouchPosition = touch.location(in: view)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            previewTouchPosition = touch.location(in: view)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        chooseTouchedAction()
        previewTouchPosition = nil
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        chooseTouchedAction()
        previewTouchPosition = nil
    }
}

extension PeekAndPopController: UIViewControllerTransitioningDelegate {

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
