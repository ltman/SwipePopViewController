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

    func addInteractivePopGesture(navigationController: UINavigationController,
                                  view: UIView) {
        if let popGestureRecognizer = navigationController.interactivePopGestureRecognizer,
           let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
            self.setValue(targets, forKey: "targets")
            view.addGestureRecognizer(self)
        }
    }
    
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
}
