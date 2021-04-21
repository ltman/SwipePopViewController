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
        case none
        case uiKitDefault
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
        case .none:
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        case .uiKitDefault:
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        case .native:
            applyNativePopGesture()
        case .swipePop:
            addSwipePopGesture()
        }
        self.title = "ViewController#\(self.navigationController!.viewControllers.count)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func applyNativePopGesture() {
        if (self.navigationController?.viewControllers.count ?? 0) > 1 {
            let popGestureRecognizer = self.navigationController!.interactivePopGestureRecognizer!
            if let targets = popGestureRecognizer.value(forKey: "targets") as? NSMutableArray {
                let gestureRecognizer = UIPanGestureRecognizer()
                gestureRecognizer.setValue(targets, forKey: "targets")
                self.view.addGestureRecognizer(gestureRecognizer)
            }
        }
    }

}
