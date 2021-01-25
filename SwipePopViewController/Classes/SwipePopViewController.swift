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

enum ViewAssociatedKeys {
    static var firstTranslation = "first_translation"
    static var panGestureRecognizer = "pan_gesture_recognizer"
    static var selfNavigationControllerDelegate = "self_navigation_controller_delegate"
    static var percentDrivenInteractiveTransition = "percent_drivenInteractive_transition"
    static var panGestureInteractor = "pan_gesture_interactor"
}

public extension UIViewController {
    private var firstTranslation: CGFloat? {
        get { return ao_get(pkey: &ViewAssociatedKeys.firstTranslation) as? CGFloat }
        set { ao_setOptional(newValue, pkey: &ViewAssociatedKeys.firstTranslation) }
    }
    
    private var panGestureRecognizer: UIPanGestureRecognizer? {
        get { return ao_get(pkey: &ViewAssociatedKeys.panGestureRecognizer) as? UIPanGestureRecognizer }
        set { ao_setOptional(newValue, pkey: &ViewAssociatedKeys.panGestureRecognizer) }
    }
    
    private var selfNavigationControllerDelegate: UINavigationControllerDelegate? {
        get { return ao_get(pkey: &ViewAssociatedKeys.selfNavigationControllerDelegate) as? UINavigationControllerDelegate }
        set { ao_setOptional(newValue, pkey: &ViewAssociatedKeys.selfNavigationControllerDelegate) }
    }
    
    private var percentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition? {
        get { return ao_get(pkey: &ViewAssociatedKeys.percentDrivenInteractiveTransition) as? UIPercentDrivenInteractiveTransition }
        set { ao_setOptional(newValue, pkey: &ViewAssociatedKeys.percentDrivenInteractiveTransition) }
    }
    
    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        guard let view = self.view else { return }
        let percent = self.firstTranslation != nil ? max(panGesture.translation(in: view).x - self.firstTranslation!, 0) / view.frame.width : 0
        
        switch panGesture.state {
        case .began:
            if panGesture.velocity(in: view).x > 0 {
                self.selfNavigationControllerDelegate = navigationController?.delegate
                self.navigationController?.delegate = self
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
    
    func addSwipeBackGesture() {
        guard self.navigationController?.viewControllers.first != self else {
            return
        }

        guard self.navigationController?.viewControllers.count > 1 else {
            return
        }

        guard panGestureRecognizer == nil else {
            return
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        self.panGestureRecognizer?.cancelsTouchesInView = true
        self.panGestureRecognizer?.delaysTouchesBegan = true
        self.panGestureRecognizer?.maximumNumberOfTouches = 1
        if let gesture = self.panGestureRecognizer {
            self.view?.addGestureRecognizer(gesture)
            self.navigationController?.interactivePopGestureRecognizer?.delegate =  self.panGestureRecognizer as? UIGestureRecognizerDelegate
        }
    }
}

extension UIViewController : UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return SlideAnimatedTransitioning()
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        navigationController.delegate = self.selfNavigationControllerDelegate
        if self.panGestureRecognizer?.state == .began && self.panGestureRecognizer?.velocity(in: view).x > 0 {
            self.percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
            self.percentDrivenInteractiveTransition?.completionCurve = .easeInOut
        } else {
            self.percentDrivenInteractiveTransition = nil
        }
        
        return self.percentDrivenInteractiveTransition
    }
}
