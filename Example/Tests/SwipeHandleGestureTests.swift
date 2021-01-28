import XCTest

@testable
import SwipePopViewController

class SwipeHandleGestureTests: XCTestCase {
    var navigationController: UINavigationControllerMock!
    var viewController: UIViewController!
    var percentDrivenMock: UIPercentDrivenInteractiveTransitionMock!
    
    override func setUp() {
        super.setUp()
        let firstViewController = UIViewController()
        viewController = UIViewController()
        navigationController = UINavigationControllerMock()
        percentDrivenMock = UIPercentDrivenInteractiveTransitionMock()

        navigationController.delegate = navigationController
        navigationController.viewControllers = [firstViewController, viewController]
        viewController.addSwipeBackGesture()
    }
    
    override func tearDown() {
        super.tearDown()
        navigationController = nil
        viewController = nil
        percentDrivenMock = nil
    }
    
    func testHandleGestureBeganState() {
        let selfDelegate: UINavigationControllerDelegate = navigationController
        let pan = PanGestureBeganStateMock()
        viewController.handlePanGesture(pan)
        
        XCTAssertNotNil(viewController.selfNavigationControllerDelegate)
        XCTAssertTrue(viewController.selfNavigationControllerDelegate === selfDelegate)
        XCTAssertNotNil(viewController.swipePopNavigationControllerDelegate)
        XCTAssertTrue(viewController.swipePopNavigationControllerDelegate === viewController.navigationController!.delegate)
        XCTAssertTrue(navigationController.didPopViewController)
    }
    
    func testHandleGestureChangedState() {
        let pan = PanGestureChangedStateMock()
        viewController.percentDrivenInteractiveTransition = percentDrivenMock
        viewController.handlePanGesture(pan)
        
        XCTAssertEqual(viewController.firstTranslation, 10)
        XCTAssertEqual(percentDrivenMock.updatePercentComplete, 0)
    }
    
    func testHandleGestureEndedStateFinish() {
        let pan = PanGestureEndedStateFinishMock()
        viewController.percentDrivenInteractiveTransition = percentDrivenMock
        viewController.handlePanGesture(pan)
        
        XCTAssertTrue(percentDrivenMock.didFinish)
        XCTAssertNil(viewController.firstTranslation)
    }
    
    func testHandleGestureEndedStateNotFinish() {
        let pan = PanGestureEndedStateNotFinishMock()
        viewController.percentDrivenInteractiveTransition = percentDrivenMock
        viewController.handlePanGesture(pan)
        
        XCTAssertTrue(percentDrivenMock.didCancel)
        XCTAssertNil(viewController.firstTranslation)
    }
    
    func testHandleGestureCancelledState() {
        let pan = PanGestureCancelledStateMock()
        viewController.percentDrivenInteractiveTransition = percentDrivenMock
        viewController.handlePanGesture(pan)
        
        XCTAssertTrue(percentDrivenMock.didCancel)
        XCTAssertNil(viewController.firstTranslation)
    }
    
    func testHandleGestureFailedState() {
        let pan = PanGestureFailedStateMock()
        viewController.percentDrivenInteractiveTransition = percentDrivenMock
        viewController.handlePanGesture(pan)
        
        XCTAssertTrue(percentDrivenMock.didCancel)
        XCTAssertNil(viewController.firstTranslation)
    }
}
