//
//  SwipePopDirectionGestureRecognizer.swift
//  SwipePopViewController
//
//  Created by Athipat Nampetch on 20/1/2565 BE.
//

import UIKit.UIGestureRecognizerSubclass

class SwipePopDirectionGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        let vel = velocity(in: view)
        if state == .began, (abs(vel.y) > abs(vel.x) || vel.x < 0) {
            state = .cancelled
        }
    }
}
