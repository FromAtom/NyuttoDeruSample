//
//  CustomPresentationController.swift
//  NyuttoDeru
//
//  Created by FromAtom on 2015/12/14.
//  Copyright © 2015年 Atom. All rights reserved.
//

import Foundation
import UIKit

final class CustomPresentationController: UIPresentationController {
	var overlayView = UIView()

	// 表示トランジション開始前に呼ばれる
	override func presentationTransitionWillBegin() {
		guard let containerView = containerView else {
			return
		}

		overlayView.frame = containerView.bounds
		overlayView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: "overlayViewDidTouch:")]
		overlayView.backgroundColor = UIColor.blackColor()
		overlayView.alpha = 0.0
		containerView.insertSubview(overlayView, atIndex: 0)

		presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ [weak self] context in
			self?.overlayView.alpha = 0.7
			}, completion: nil)
	}

	// 非表示トランジション開始前に呼ばれる
	override func dismissalTransitionWillBegin() {
		presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ [weak self] context in
			self?.overlayView.alpha = 0.0
			}, completion: nil)
	}

	// 非表示トランジション開始後に呼ばれる
	override func dismissalTransitionDidEnd(completed: Bool) {
		if completed {
			overlayView.removeFromSuperview()
		}
	}

	let margin = (x: CGFloat(30), y: CGFloat(220.0))
	override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
		return CGSize(width: parentSize.width - margin.x, height: parentSize.height - margin.y)
	}

	override func frameOfPresentedViewInContainerView() -> CGRect {
		var presentedViewFrame = CGRectZero
		let containerBounds = containerView!.bounds
		let childContentSize = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerBounds.size)
		presentedViewFrame.size = childContentSize
		presentedViewFrame.origin.x = margin.x / 2.0 //containerBounds.size.width - presentedViewFrame.size.width - margin.x / 2.0
		presentedViewFrame.origin.y = margin.y / 2.0 //containerBounds.size.height - presentedViewFrame.size.height - margin.y / 2.0

		return presentedViewFrame
	}

	// レイアウト開始前に呼ばれる
	override func containerViewWillLayoutSubviews() {
		overlayView.frame = containerView!.bounds
		presentedView()!.frame = frameOfPresentedViewInContainerView()
	}

	// レイアウト開始後に呼ばれる
	override func containerViewDidLayoutSubviews() {
	}

	// overlayViewをタップしたときに呼ばれる
	func overlayViewDidTouch(sender: AnyObject) {
		presentedViewController.dismissViewControllerAnimated(true, completion: nil)
	}

}
