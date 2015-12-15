//
//  CustomAnimatedTransitioning.swift
//  NyuttoDeru
//
//  Created by FromAtom on 2015/12/14.
//  Copyright © 2015年 Atom. All rights reserved.
//

import Foundation
import UIKit

final class CustomAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
	let isPresent: Bool
	let atButton: UIButton

	init(isPresent: Bool, atButton: UIButton?) {
		self.isPresent = isPresent
		self.atButton = atButton ?? UIButton(frame: CGRectZero)
	}

	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.5
	}

	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		if isPresent {
			animatePresentTransition(transitionContext)
		} else {
			animateDissmissalTransition(transitionContext)
		}
	}

	func animatePresentTransition(transitionContext: UIViewControllerContextTransitioning) {
		guard
			let presentingController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
			let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
			let containerView = transitionContext.containerView()
			else {
				return
		}

		presentedController.view.layer.cornerRadius = 4.0
		presentedController.view.clipsToBounds = true
		presentedController.view.alpha = 0.0
		presentedController.view.transform = CGAffineTransformMakeScale(0.01, 0.01)

		containerView.insertSubview(presentedController.view, belowSubview: presentingController.view)

		UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.6, options: .CurveLinear, animations: {
			presentedController.view.alpha = 1.0
			presentedController.view.frame.origin.x = containerView.bounds.size.width - self.atButton.frame.origin.x
			presentedController.view.frame.origin.y = containerView.bounds.size.height - self.atButton.frame.origin.y
			presentedController.view.transform = CGAffineTransformIdentity
			}, completion: { finished in
				transitionContext.completeTransition(true)
		})
	}

	func animateDissmissalTransition(transitionContext: UIViewControllerContextTransitioning) {
		guard let presentedController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
			return
		}

		UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.6, options: .CurveLinear, animations:{
			presentedController.view.alpha = 0.0
			presentedController.view.transform = CGAffineTransformMakeScale(0.01, 0.01)
			presentedController.view.frame.origin.x = self.atButton.frame.origin.x
			presentedController.view.frame.origin.y = self.atButton.frame.origin.y

			}, completion: { finished in
				transitionContext.completeTransition(true)
		})
	}

}