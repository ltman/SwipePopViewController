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
        case native
        case panGesture
        case swipePop
    }
    
    var mode: Mode = .native
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func tapPushVC(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        
        vc.mode = Mode(rawValue: sender.tag) ?? .native
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        switch mode {
        case .none:
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        case .native:
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        case .panGesture:
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        return cell
    }
    
    
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
