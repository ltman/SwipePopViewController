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

    @IBAction func tapPushVC(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "viewController")
        let s = SomeClass()
        print("\(s.hello())")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

