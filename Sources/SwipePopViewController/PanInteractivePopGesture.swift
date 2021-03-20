//
//  PanInteractivePopGesture.swift
//  SwipePopViewController
//
//  Created by Athipat Nampetch on 1/3/2564 BE.
//

import UIKit
import Foundation

class PanInteractivePopGesture: UIPanGestureRecognizer {
    var firstTranslation: CGPoint = .zero
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        if state == .began {
            firstTranslation = translation(in: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        firstTranslation = .zero
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        firstTranslation = .zero
    }
    
    override func translation(in view: UIView?) -> CGPoint {
        let t = super.translation(in: view)
        return CGPoint(x: t.x - firstTranslation.x, y: t.y - firstTranslation.y)
    }
    
    override func velocity(in view: UIView?) -> CGPoint {
        return super.translation(in: view).x > 50 ? super.velocity(in: view) : .zero
    }
}

extension PanInteractivePopGesture: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let p = gestureRecognizer as? PanInteractivePopGesture {
            let t = p.translation(in: nil)
            return t.x > 0 && t.x > abs(t.y)
        }
        return false
    }
}
