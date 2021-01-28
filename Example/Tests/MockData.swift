//
//  MockData.swift
//  SwipePopViewController_Tests
//
//  Created by Thanapat Sorralump on 28/1/2564 BE.
//  Copyright © 2564 CocoaPods. All rights reserved.
//

import UIKit

class UIPercentDrivenInteractiveTransitionMock: UIPercentDrivenInteractiveTransition {
    var updatePercentComplete: CGFloat?
    var didCancel: Bool = false
    var didFinish: Bool = false
    override func update(_ percentComplete: CGFloat) {
        updatePercentComplete = percentComplete
    }

    override func cancel() {
        didCancel = true
    }

    override func finish() {
        didFinish = true
    }
}

class UINavigationControllerMock: UINavigationController {
    var didPopViewController: Bool = false
    override func popViewController(animated: Bool) -> UIViewController? {
        didPopViewController = true
        return nil
    }
}

extension UINavigationControllerMock: UINavigationControllerDelegate {}

class PanGestureBeganStateMock: UIPanGestureRecognizer {
    override var state: UIGestureRecognizer.State {
        get { .began }
        set {}
    }
    
    override func velocity(in view: UIView?) -> CGPoint {
        CGPoint(x: 10, y: 0)
    }
}

class PanGestureChangedStateMock: UIPanGestureRecognizer {
    override var state: UIGestureRecognizer.State {
        get { .changed }
        set {}
    }
    
    override func translation(in view: UIView?) -> CGPoint {
        CGPoint(x: 10, y: 0)
    }
}

class PanGestureEndedStateFinishMock: UIPanGestureRecognizer {
    override var state: UIGestureRecognizer.State {
        get { .ended }
        set {}
    }
    
    override func translation(in view: UIView?) -> CGPoint {
        CGPoint(x: 100, y: 0)
    }
    
    override func velocity(in view: UIView?) -> CGPoint {
        CGPoint(x: 500, y: 0)
    }
}

class PanGestureEndedStateNotFinishMock: UIPanGestureRecognizer {
    override var state: UIGestureRecognizer.State {
        get { .ended }
        set {}
    }
    
    override func translation(in view: UIView?) -> CGPoint {
        CGPoint(x: 10, y: 0)
    }
    
    override func velocity(in view: UIView?) -> CGPoint {
        CGPoint(x: 10, y: 0)
    }
}


class PanGestureCancelledStateMock: UIPanGestureRecognizer {
    override var state: UIGestureRecognizer.State {
        get { .cancelled }
        set {}
    }
}

class PanGestureFailedStateMock: UIPanGestureRecognizer {
    override var state: UIGestureRecognizer.State {
        get { .failed }
        set {}
    }
}

class UIViewControllerAnimatedTransitioningMock: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}
}
