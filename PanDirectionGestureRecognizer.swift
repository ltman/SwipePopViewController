//
//  PanDirectionGestureRecognizer.swift
//  SwipePopViewController
//
//  Created by Athipat Nampetch on 20/1/2565 BE.
//

import UIKit.UIGestureRecognizerSubclass

class PanDirectionGestureRecognizer: UIPanGestureRecognizer {

    let direction: PanDirection
    
    enum PanDirection {
        case vertical
        case horizontal
    }

    init(direction: PanDirection, target: AnyObject, action: Selector) {
        self.direction = direction
        super.init(target: target, action: action)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        if state == .began {
            let vel = velocity(in: view)
            switch direction {
            case .horizontal where abs(vel.y) > abs(vel.x):
                state = .cancelled
            case .vertical where abs(vel.x) > abs(vel.y):
                state = .cancelled
            default:
                break
            }
        }
    }
}
