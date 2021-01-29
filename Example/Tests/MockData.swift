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

class NavigationControllerDelegateMock: NSObject, UINavigationControllerDelegate {}

class PanGestureRecognizerMock: UIPanGestureRecognizer {
    var mockState: UIGestureRecognizer.State
    
    override var state: UIGestureRecognizer.State {
        get { mockState }
        set { mockState = newValue }
    }
    
    var mockVelocity: CGPoint
    var velocityInViews = [UIView?]()
    override func velocity(in view: UIView?) -> CGPoint {
        velocityInViews.append(view)
        return mockVelocity
    }
    
    var mockTranslation: CGPoint
    var translationInView = [UIView?]()
    override func translation(in view: UIView?) -> CGPoint {
        translationInView.append(view)
        return mockTranslation
    }
    
    init(mockState: UIGestureRecognizer.State = .began,
         mockVelocity: CGPoint = .zero,
         mockTranslation: CGPoint = .zero) {
        self.mockState = mockState
        self.mockVelocity = mockVelocity
        self.mockTranslation = mockTranslation
        super.init(target: nil, action: nil)
    }
}

class UIViewControllerAnimatedTransitioningMock: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}
}
