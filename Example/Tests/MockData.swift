//
//  MockData.swift
//  SwipePopViewController_Tests
//
//  Created by Thanapat Sorralump on 3/3/2564 BE.
//  Copyright © 2564 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

@testable
import SwipePopViewController

class PanGestureRecognizerMock: PanInteractivePopGesture {
    var mockState: UIGestureRecognizer.State
    
    override var state: UIGestureRecognizer.State {
        get { mockState }
        set { mockState = newValue }
    }
    
    var mockTranslation: CGPoint
    var translationInView = [UIView?]()
    
    override func translation(in view: UIView?) -> CGPoint {
        translationInView.append(view)
        return mockTranslation
    }
    
    init(mockState: UIGestureRecognizer.State = .began,
         mockTranslation: CGPoint = .zero) {
        self.mockState = mockState
        self.mockTranslation = mockTranslation
        super.init(target: nil, action: nil)
    }
}
