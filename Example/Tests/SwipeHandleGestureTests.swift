import XCTest

@testable
import SwipePopViewController

class SwipeHandleGestureTests: XCTestCase {
    var navigationController: UINavigationControllerMock!
    var viewController: UIViewController!
    var percentDrivenMock: UIPercentDrivenInteractiveTransitionMock!
    var originalNavigationControllerDelegate: UINavigationControllerDelegate! = NavigationControllerDelegateMock()
    
    override func setUp() {
        super.setUp()
        let firstViewController = UIViewController()
        viewController = UIViewController()
        navigationController = UINavigationControllerMock()
        percentDrivenMock = UIPercentDrivenInteractiveTransitionMock()

        navigationController.delegate = originalNavigationControllerDelegate
        navigationController.viewControllers = [firstViewController, viewController]
        viewController.addSwipePopGesture()
    }
    
    override func tearDown() {
        super.tearDown()
        navigationController = nil
        viewController = nil
        percentDrivenMock = nil
    }
    
//    func testHandleGestureBeganState() {
//        let selfDelegate: UINavigationControllerDelegate = originalNavigationControllerDelegate
//        let pan = PanGestureRecognizerMock(mockState: .began, mockVelocity: CGPoint(x: 10, y: 0), mockTranslation: CGPoint(x: 10, y: 0))
//        XCTAssertTrue(viewController.navigationController!.delegate === selfDelegate)
//        
//        viewController.handlePanGesture(pan)
//        
//        XCTAssertTrue(viewController.selfNavigationControllerDelegate! === selfDelegate)
//        XCTAssertTrue(
//            viewController.navigationController!.delegate === viewController.swipePopNavigationControllerDelegate!,
//            "nav delegate is replaced by our swipe pop nav delegate")
//        XCTAssertTrue(viewController.navigationController!.delegate is SwipePopNavigationControllerDelegate)
//        XCTAssertTrue(navigationController.didPopViewController)
//    }
//    
//    func testHandleGestureFirstChanged() {
//        let pan = PanGestureRecognizerMock(mockState: .changed, mockVelocity: CGPoint(x: 10, y: 0), mockTranslation: CGPoint(x: 10, y: 0))
//        viewController.percentDrivenInteractiveTransition = percentDrivenMock
//        viewController.handlePanGesture(pan)
//        
//        XCTAssertEqual(
//            viewController.firstTranslation, 10,
//            "translation.x of the 1st changed event shall be kept for later calculation")
//        XCTAssertEqual(percentDrivenMock.updatePercentComplete, 0)
//    }
//    
//    func testHandleGestureChangedStateUpdating() {
//        let pan = PanGestureRecognizerMock(mockState: .changed, mockVelocity: CGPoint(x: 10, y: 0), mockTranslation: CGPoint(x: 10, y: 0))
//        viewController.firstTranslation = 5
//        viewController.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        viewController.percentDrivenInteractiveTransition = percentDrivenMock
//        viewController.handlePanGesture(pan)
//        
//        XCTAssertEqual(viewController.firstTranslation, 5)
//        XCTAssertEqual(percentDrivenMock.updatePercentComplete, 0.05)
//    }
//    
//    func testHandleGestureEndedStateFinish() {
//        let pan = PanGestureRecognizerMock(mockState: .ended, mockVelocity: CGPoint(x: 500, y: 0), mockTranslation: CGPoint(x: 100, y: 0))
//        viewController.percentDrivenInteractiveTransition = percentDrivenMock
//        viewController.handlePanGesture(pan)
//        
//        XCTAssertTrue(percentDrivenMock.didFinish)
//        XCTAssertNil(viewController.firstTranslation)
//    }
//    
//    func testHandleGestureEndedStateNotFinish() {
//        let pan = PanGestureRecognizerMock(mockState: .ended, mockVelocity: CGPoint(x: 10, y: 0), mockTranslation: CGPoint(x: 10, y: 0))
//        viewController.percentDrivenInteractiveTransition = percentDrivenMock
//        viewController.handlePanGesture(pan)
//        
//        XCTAssertTrue(percentDrivenMock.didCancel)
//        XCTAssertNil(viewController.firstTranslation)
//    }
//    
//    func testHandleGestureCancelledState() {
//        let pan = PanGestureRecognizerMock(mockState: .cancelled, mockVelocity: CGPoint(x: 10, y: 0), mockTranslation: CGPoint(x: 10, y: 0))
//        viewController.percentDrivenInteractiveTransition = percentDrivenMock
//        viewController.handlePanGesture(pan)
//        
//        XCTAssertTrue(percentDrivenMock.didCancel)
//        XCTAssertNil(viewController.firstTranslation)
//    }
//    
//    func testHandleGestureFailedState() {
//        let pan = PanGestureRecognizerMock(mockState: .failed, mockVelocity: CGPoint(x: 10, y: 0), mockTranslation: CGPoint(x: 10, y: 0))
//        viewController.percentDrivenInteractiveTransition = percentDrivenMock
//        viewController.handlePanGesture(pan)
//        
//        XCTAssertTrue(percentDrivenMock.didCancel)
//        XCTAssertNil(viewController.firstTranslation)
//    }
//
//    func testOriginalDelegateKeepUsingWeak() {
//        let pan = PanGestureRecognizerMock(mockState: .ended, mockVelocity: CGPoint(x: 500, y: 0), mockTranslation: CGPoint(x: 100, y: 0))
//        viewController.percentDrivenInteractiveTransition = percentDrivenMock
//        viewController.handlePanGesture(pan)
//        originalNavigationControllerDelegate = nil
//        
//        XCTAssertNil(viewController.selfNavigationControllerDelegate)
//    }
}
