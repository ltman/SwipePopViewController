//
//  SwipePopViewController.swift
//
//  Created by Athipat Nampetch on 22/1/2564 BE.
//

import UIKit
import Foundation

public extension UIViewController {
    func addSwipePopGesture() {
        guard let nc = self.navigationController,
              nc.viewControllers.first != self,
              nc.viewControllers.count > 1,
              (view.gestureRecognizers?.filter({ $0 is PanInteractivePopGesture }).isEmpty ?? false || view.gestureRecognizers == nil) else {
            return
        }
        
        if let popGestureRecognizer = navigationController?.interactivePopGestureRecognizer,
           let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
            let popGesture = PanInteractivePopGesture()
            popGesture.setValue(targets, forKey: "targets")
            view.addGestureRecognizer(popGesture)
        }
    }
}

