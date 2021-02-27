//
//  ViewController.swift
//  SwipePopViewController
//
//  Created by chalermpong on 01/22/2021.
//  Copyright (c) 2021 chalermpong. All rights reserved.
//

import UIKit
import SwipePopViewController

class ViewController: UIViewController {
    
    enum Mode: Int {
        case native
        case swipePop
    }
    
    var mode: Mode = .native
    
    @IBAction func tapPushVC(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        
        vc.mode = Mode(rawValue: sender.tag) ?? .native
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch mode {
        case .native:
            applyNativePopGesture()
        case .swipePop:
            addSwipePopGesture()
        }
        self.title = "ViewController#\(self.navigationController!.viewControllers.count)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        Uncomment if want to test add gesture repeatly
//        if mode == .native {
//            applyNativePopGesture()
//        }
        super.viewWillAppear(animated)
        print("viewWillAppear")
        Thread.sleep(forTimeInterval: 0.2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    
    private func applyNativePopGesture() {
        if let nc = self.navigationController {
            let popGesture = PanInteractivePopGesture()
            popGesture.addInteractivePopGesture(navigationController: nc, view: self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

class PanInteractivePopGesture: UIPanGestureRecognizer {

    func addInteractivePopGesture(navigationController: UINavigationController,
                                  view: UIView) {
        if navigationController.viewControllers.count > 1,
           (view.gestureRecognizers?.filter({ $0 is Self }).isEmpty ?? false || view.gestureRecognizers == nil) {
            if let popGestureRecognizer = navigationController.interactivePopGestureRecognizer,
               let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
                self.setValue(targets, forKey: "targets")
                self.addTarget(self, action: #selector(panTarget))
                view.addGestureRecognizer(self)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        print("touchesBegan")
        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        print("touchesMoved at \(Date().timeIntervalSince(lastBeginTime))")
        super.touchesMoved(touches, with: event)
        if state == .began {
            firstTranslation = translation(in: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        print("touchesEnded")
        super.touchesEnded(touches, with: event)
        firstTranslation = .zero
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        print("touchesCancelled")
        super.touchesCancelled(touches, with: event)
        firstTranslation = .zero
    }
    
    var firstTranslation: CGPoint = .zero
    var lastBeginTime = Date()
    @objc func panTarget(_ gestureRecognizer: UIPanGestureRecognizer) {
        print("GestureState=\(gestureRecognizer.state.rawValue)")
        switch gestureRecognizer.state {
        case .began:
            lastBeginTime = Date()
        default:
            break
        }
        //self.state = gestureRecognizer.state
    }
    
    override func translation(in view: UIView?) -> CGPoint {
        if state == .began {
            print("")
        }
        let t = super.translation(in: view)
        print("translation \(t) at \(Date().timeIntervalSince(lastBeginTime))")
        return CGPoint(x: t.x - firstTranslation.x, y: t.y - firstTranslation.y)
    }

    override func velocity(in view: UIView?) -> CGPoint {
        let v = super.velocity(in: view)
        print("velocity \(v) at \(Date().timeIntervalSince(lastBeginTime))")
        return v
    }

    
    deinit {
        print("deinit")
    }
}
