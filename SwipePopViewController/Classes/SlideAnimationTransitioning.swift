//
//  SlideAnimationTransition.swift
//
//  Created by Athipat Nampetch on 22/1/2564 BE.
//

import UIKit

public class SlideAnimatedTransitioning: NSObject {
}

extension SlideAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView

        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        toView.frame = transitionContext.finalFrame(for: toViewController)
        toView.frame = CGRect(x: toView.frame.origin.x, y: toView.frame.origin.y, width: toView.frame.size.width, height: toView.frame.size.height)

        let width = containerView.frame.width
        
        var offsetLeft = fromView.frame
        offsetLeft.origin.x = width
        
        var offscreenRight = toView.frame
        offscreenRight.origin.x = -width / 3.33;
        
        toView.frame = offscreenRight;
        
        fromView.layer.shadowRadius = 5.0
        fromView.layer.shadowOpacity = 1.0
        toView.layer.opacity = 0.9
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay:0, options:.curveLinear, animations:{
            toView.frame = CGRect(x: fromView.frame.origin.x, y: toView.frame.origin.y, width: toView.frame.width, height: toView.frame.height)
            fromView.frame = offsetLeft
            
            toView.layer.opacity = 1.0
            fromView.layer.shadowOpacity = 0.1
            
        }, completion: { finished in
            toView.layer.opacity = 1.0
            toView.layer.shadowOpacity = 0
            fromView.layer.opacity = 1.0
            fromView.layer.shadowOpacity = 0
    
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
}
