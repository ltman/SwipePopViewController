//
//  SwipePopViewController.swift
//
//  Created by Athipat Nampetch on 22/1/2564 BE.
//

import UIKit
import Foundation

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

fileprivate enum ViewAssociatedKeys {
    static var firstTranslation = "swipepop.first_translation"
    static var panGestureRecognizer = "swipepop.pan_gesture_recognizer"
    static var selfNavigationControllerDelegate = "swipepop.self_navigation_controller_delegate"
    static var percentDrivenInteractiveTransition = "swipepop.percent_drivenInteractive_transition"
    static var panGestureInteractor = "swipepop.pan_gesture_interactor"
    static var swipePopNavigationControllerDelegate = "swipepop.swipe_pop_navigation_controller_delegate"
}

extension UIViewController {
    var firstTranslation: CGFloat? {
        get { return ao_get(pkey: &ViewAssociatedKeys.firstTranslation) as? CGFloat }
        set { ao_setOptional(newValue, pkey: &ViewAssociatedKeys.firstTranslation) }
    }
    
    var panGestureRecognizer: UIPanGestureRecognizer? {
        get { return ao_get(pkey: &ViewAssociatedKeys.panGestureRecognizer) as? UIPanGestureRecognizer }
        set { ao_setOptional(newValue, pkey: &ViewAssociatedKeys.panGestureRecognizer) }
    }
    
    var selfNavigationControllerDelegate: UINavigationControllerDelegate? {
        get { return ao_get(pkey: &ViewAssociatedKeys.selfNavigationControllerDelegate) as? UINavigationControllerDelegate }
        set { ao_setWeak(newValue, pkey: &ViewAssociatedKeys.selfNavigationControllerDelegate) }
    }
    
    var percentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition? {
        get { return ao_get(pkey: &ViewAssociatedKeys.percentDrivenInteractiveTransition) as? UIPercentDrivenInteractiveTransition }
        set { ao_setOptional(newValue, pkey: &ViewAssociatedKeys.percentDrivenInteractiveTransition) }
    }
    
    var swipePopNavigationControllerDelegate: SwipePopNavigationControllerDelegate? {
        get { return ao_get(pkey: &ViewAssociatedKeys.swipePopNavigationControllerDelegate) as? SwipePopNavigationControllerDelegate }
        set { ao_setOptional(newValue, pkey: &ViewAssociatedKeys.swipePopNavigationControllerDelegate) }
    }
    
    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        guard let view = self.view else { return }
        let percent = self.firstTranslation != nil ? max(panGesture.translation(in: view).x - self.firstTranslation!, 0) / view.frame.width : 0
        
        switch panGesture.state {
        case .began:
            if panGesture.velocity(in: view).x > 0 {
                self.selfNavigationControllerDelegate = navigationController?.delegate
                self.navigationController?.delegate = swipePopNavigationControllerDelegate
                _ = self.navigationController?.popViewController(animated: true)
            }
        case .changed:
            if let percentDrivenInteractiveTransition = self.percentDrivenInteractiveTransition {
                if self.firstTranslation == nil {
                    self.firstTranslation = panGesture.translation(in: self.view).x
                }
                percentDrivenInteractiveTransition.update(percent)
            }
            
        case .ended:
            let velocity = panGesture.velocity(in: view).x
            // Continue if drag more than 50% of screen width or velocity is higher than 300
            if let percentDrivenInteractiveTransition = self.percentDrivenInteractiveTransition {
                if percent > 0.5 || velocity > 300 {
                    percentDrivenInteractiveTransition.finish()
                } else {
                    percentDrivenInteractiveTransition.cancel()
                }
            }
            self.firstTranslation = nil
        case .cancelled, .failed:
            self.percentDrivenInteractiveTransition?.cancel()
            self.firstTranslation = nil
        default:
            self.firstTranslation = nil
            break
        }
    }
}

public extension UIViewController {
    func addSwipePopGesture() {
        guard self.navigationController?.viewControllers.first != self else {
            return
        }
        
        guard self.navigationController?.viewControllers.count > 1 else {
            return
        }
        
        guard panGestureRecognizer == nil else {
            // PS: If there is a panGestureRecognizer already, We have not to add the gesture again.
            return
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.swipePopNavigationControllerDelegate = SwipePopNavigationControllerDelegate(viewControllerDelegate: self)
        self.panGestureRecognizer = SwipePopDirectionGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        self.panGestureRecognizer?.cancelsTouchesInView = true
        self.panGestureRecognizer?.delaysTouchesBegan = true
        self.panGestureRecognizer?.maximumNumberOfTouches = 1
        if let gesture = self.panGestureRecognizer {
            self.view?.addGestureRecognizer(gesture)
        }
    }
}

class SwipePopNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    weak var viewControllerDelegate: UIViewController?
    
    init(viewControllerDelegate: UIViewController?) {
        self.viewControllerDelegate = viewControllerDelegate
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideAnimatedTransitioning(delegate: fromVC as? SlideAnimatedTransitioningDelegate)
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let viewControllerDelegate = viewControllerDelegate else { return nil }
        navigationController.delegate = viewControllerDelegate.selfNavigationControllerDelegate
        if viewControllerDelegate.panGestureRecognizer?.state == .began && viewControllerDelegate.panGestureRecognizer?.velocity(in: viewControllerDelegate.view).x > 0 {
            viewControllerDelegate.percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
            viewControllerDelegate.percentDrivenInteractiveTransition?.completionCurve = .easeInOut
        } else {
            viewControllerDelegate.percentDrivenInteractiveTransition = nil
        }
        return viewControllerDelegate.percentDrivenInteractiveTransition
    }
}
