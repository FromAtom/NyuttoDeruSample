//
//  ViewController.swift
//  NyuttoDeru
//
//  Created by FromAtom on 2015/12/08.
//  Copyright © 2015年 Atom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var atButton: UIButton?

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	@IBAction func OpenButtonTouchUpInside(sender: UIButton) {
		atButton = sender

		let modalViewController = ModalViewController()
		modalViewController.modalPresentationStyle = .Custom
		modalViewController.transitioningDelegate = self
		presentViewController(modalViewController, animated: true, completion: nil)
	}
}

extension ViewController: UIViewControllerTransitioningDelegate {
	func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
		return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
	}
}

extension ViewController {
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

		return CustomAnimatedTransitioning(isPresent: true, atButton: atButton)
	}

	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return CustomAnimatedTransitioning(isPresent: false, atButton: atButton)
	}
}