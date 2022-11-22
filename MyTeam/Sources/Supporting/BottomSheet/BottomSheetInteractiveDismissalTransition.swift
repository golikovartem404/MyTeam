//
//  BottomSheetInteractiveDismissalTransition.swift
//  MyTeam
//
//  Created by User on 22.11.2022.
//

import UIKit

final class BottomSheetInteractiveDismissalTransition: NSObject {

    // MARK: - Properties

    var bottomConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?

    private let stretchOffset: CGFloat = 16
    private let maxTransitionDuration: CGFloat = 0.25
    private let minTransitionDuration: CGFloat = 0.15
    private let animationCurve: UIView.AnimationCurve = .easeIn

    private weak var transitionContext: UIViewControllerContextTransitioning?

    private var heightAnimator: UIViewPropertyAnimator?
    private var offsetAnimator: UIViewPropertyAnimator?

    private var interactiveDismissal: Bool = false
}

// MARK: - Public methods

extension BottomSheetInteractiveDismissalTransition {

    func start(moving presentedView: UIView, interactiveDismissal: Bool) {
        self.interactiveDismissal = interactiveDismissal

        heightAnimator?.stopAnimation(false)
        heightAnimator?.finishAnimation(at: .start)
        offsetAnimator?.stopAnimation(false)
        offsetAnimator?.finishAnimation(at: .start)

        heightAnimator = createHeightAnimator(
            animating: presentedView, from: presentedView.frame.height
        )

        if !interactiveDismissal {
            offsetAnimator = createOffsetAnimator(
                animating: presentedView, to: stretchOffset
            )
        }
    }

    func move(_ presentedView: UIView, using translation: CGFloat) {
        let progress = translation / presentedView.frame.height

        let stretchProgress = stretchProgress(basedOn: translation)

        heightAnimator?.fractionComplete = stretchProgress * -1
        offsetAnimator?.fractionComplete = interactiveDismissal ? progress : stretchProgress

        transitionContext?.updateInteractiveTransition(progress)
    }

    func stop(moving presentedView: UIView, at translation: CGFloat, with velocity: CGPoint) {
        let progress = translation / presentedView.frame.height

        let stretchProgress = stretchProgress(basedOn: translation)

        heightAnimator?.fractionComplete = stretchProgress * -1
        offsetAnimator?.fractionComplete = interactiveDismissal ? progress : stretchProgress

        transitionContext?.updateInteractiveTransition(progress)

        let cancelDismiss = !interactiveDismissal || velocity.y < 500 || (progress < 0.5 && velocity.y <= .zero)

        heightAnimator?.isReversed = true
        offsetAnimator?.isReversed = cancelDismiss

        if cancelDismiss {
            transitionContext?.cancelInteractiveTransition()
        } else {
            transitionContext?.finishInteractiveTransition()
        }

        if progress < .zero {
            heightAnimator?.addCompletion { _ in
                self.offsetAnimator?.stopAnimation(false)
                self.offsetAnimator?.finishAnimation(at: .start)
            }

            heightAnimator?.startAnimation()
        } else {
            offsetAnimator?.addCompletion { _ in
                self.heightAnimator?.stopAnimation(false)
                self.heightAnimator?.finishAnimation(at: .start)
            }

            offsetAnimator?.startAnimation()
        }

        interactiveDismissal = false
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension BottomSheetInteractiveDismissalTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        maxTransitionDuration
    }

    /// This method is never called since we only care about interactive transitions, and use UIKit's default transitions/animations for non-interactive transitions.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedView = transitionContext.view(forKey: .from) else {
            return
        }

        offsetAnimator?.stopAnimation(true)

        let offset = presentedView.frame.height
        let offsetAnimator = createOffsetAnimator(animating: presentedView, to: offset)

        offsetAnimator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        offsetAnimator.startAnimation()

        self.offsetAnimator = offsetAnimator
    }

    func interruptibleAnimator(
        using transitionContext: UIViewControllerContextTransitioning
    ) -> UIViewImplicitlyAnimating {
        guard let offsetAnimator = offsetAnimator else {
            fatalError("Somehow the offset animator was not set")
        }

        return offsetAnimator
    }
}

// MARK: - UIViewControllerInteractiveTransitioning

extension BottomSheetInteractiveDismissalTransition: UIViewControllerInteractiveTransitioning {

    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        guard
            transitionContext.isInteractive,
            let presentedView = transitionContext.view(forKey: .from)
        else {
            return animateTransition(using: transitionContext)
        }

        let fractionComplete = offsetAnimator?.fractionComplete ?? .zero

        offsetAnimator?.stopAnimation(true)

        let offset = presentedView.frame.height
        let offsetAnimator = createOffsetAnimator(animating: presentedView, to: offset)

        offsetAnimator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        offsetAnimator.fractionComplete = fractionComplete

        transitionContext.updateInteractiveTransition(fractionComplete)

        self.offsetAnimator = offsetAnimator
        self.transitionContext = transitionContext
    }

    var wantsInteractiveStart: Bool {
        interactiveDismissal
    }

    var completionCurve: UIView.AnimationCurve {
        animationCurve
    }

    var completionSpeed: CGFloat {
        1.0
    }
}

// MARK: - Private Methods

private extension BottomSheetInteractiveDismissalTransition {

    func createHeightAnimator(animating view: UIView, from height: CGFloat) -> UIViewPropertyAnimator {
        let propertyAnimator = UIViewPropertyAnimator(
            duration: minTransitionDuration,
            curve: animationCurve
        )

        heightConstraint?.constant = height
        heightConstraint?.isActive = true

        let finalHeight = height + stretchOffset

        propertyAnimator.addAnimations {
            self.heightConstraint?.constant = finalHeight
            view.superview?.layoutIfNeeded()
        }

        propertyAnimator.addCompletion { position in
            self.heightConstraint?.isActive = position == .end ? true : false
            self.heightConstraint?.constant = position == .end ? finalHeight : height
        }

        return propertyAnimator
    }
    
    func createOffsetAnimator(animating view: UIView, to offset: CGFloat) -> UIViewPropertyAnimator {
        let propertyAnimator = UIViewPropertyAnimator(
            duration: maxTransitionDuration,
            curve: animationCurve
        )

        propertyAnimator.addAnimations {
            self.bottomConstraint?.constant = offset
            view.superview?.layoutIfNeeded()
        }

        propertyAnimator.addCompletion { position in
            self.bottomConstraint?.constant = position == .end ? offset : .zero
        }

        return propertyAnimator
    }

    func stretchProgress(basedOn translation: CGFloat) -> CGFloat {
        (translation > .zero ? pow(translation, 0.33) : -pow(-translation, 0.33)) / stretchOffset
    }
}

