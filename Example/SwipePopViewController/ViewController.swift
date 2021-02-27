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
            addSwipePopGesture()
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

}
