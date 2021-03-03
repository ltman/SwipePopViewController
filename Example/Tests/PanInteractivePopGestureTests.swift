import XCTest

@testable
import SwipePopViewController

class PanInteractivePopGestureTests: XCTestCase {
    func testPanInteractivePopGestureTouchesEnded() {
        let panInteractivePopGesture = PanInteractivePopGesture()
        panInteractivePopGesture.firstTranslation = CGPoint(x: 10, y: 10)
        panInteractivePopGesture.touchesEnded(Set<UITouch>(), with: UIEvent())
        
        XCTAssertEqual(panInteractivePopGesture.firstTranslation, .zero)
    }
    
    func testPanInteractivePopGestureTouchesCancelled() {
        let panInteractivePopGesture = PanInteractivePopGesture()
        panInteractivePopGesture.firstTranslation = CGPoint(x: 10, y: 10)
        panInteractivePopGesture.touchesCancelled(Set<UITouch>(), with: UIEvent())
        
        XCTAssertEqual(panInteractivePopGesture.firstTranslation, .zero)
    }
    
    func testPanInteractivePopGestureTranslation() {
        let panInteractivePopGesture = PanInteractivePopGesture()
        panInteractivePopGesture.firstTranslation = CGPoint(x: 10, y: 10)
        let point = panInteractivePopGesture.translation(in: UIView())
        
        XCTAssertEqual(point, CGPoint(x: -10, y: -10))
    }
    
    func testPanInteractivePopGestureTouchesMovedBeganState() {
        let panInteractivePopGesture = PanGestureRecognizerMock(mockState: .began, mockTranslation: CGPoint(x: 10, y: 10))
        panInteractivePopGesture.touchesMoved(Set<UITouch>(), with: UIEvent())
        
        XCTAssertEqual(panInteractivePopGesture.firstTranslation, CGPoint(x: 10, y: 10))
    }
    
    func testPanInteractivePopGestureTouchesMovedChangedState() {
        let panInteractivePopGesture = PanGestureRecognizerMock(mockState: .changed, mockTranslation: CGPoint(x: 10, y: 10))
        panInteractivePopGesture.touchesMoved(Set<UITouch>(), with: UIEvent())
        
        XCTAssertEqual(panInteractivePopGesture.firstTranslation, .zero)
    }
}
