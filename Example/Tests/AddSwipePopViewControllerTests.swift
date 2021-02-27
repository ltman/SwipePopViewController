import XCTest

@testable
import SwipePopViewController

class AddSwipePopViewControllerTests: XCTestCase {
//    func testSwipePopNotAvailableInFirstViewController() {
//        let mockSwipeViewController = UIViewController()
//        _ = UINavigationController(rootViewController: mockSwipeViewController)
//        mockSwipeViewController.addSwipePopGesture()
//        XCTAssertNil(
//            mockSwipeViewController.panGestureRecognizer,
//            "addSwipePopGesture() shall has no effect on the 1st UIViewController of UINavigationController because it can't be pop")
//    }
//    
//    func testSwipePopAvailableInSecondViewController() {
//        let mockFirstSwipeViewController = UIViewController()
//        let mockSecondSwipeViewController = UIViewController()
//        let navigationController = UINavigationController()
//        navigationController.viewControllers = [mockFirstSwipeViewController, mockSecondSwipeViewController]
//        mockSecondSwipeViewController.addSwipePopGesture()
//        XCTAssertNotNil(
//            mockSecondSwipeViewController.panGestureRecognizer,
//            "addSwipePopGesture() shall add a Pan Gesture Recognizer from the 2nd UIViewController of UINavigationController"
//        )
//    }
//    
//    func testAddSwipePopMoreThanOnce() {
//        let firstViewController = UIViewController()
//        let secondViewController = UIViewController()
//        let navigationController = UINavigationController()
//        navigationController.viewControllers = [firstViewController, secondViewController]
//        secondViewController.addSwipePopGesture()
//        secondViewController.addSwipePopGesture()
//        XCTAssertEqual(
//            secondViewController.view.gestureRecognizers!.count,
//            1,
//            "addSwipePopGesture() shall has no effect if the UIViewController already called addSwipePopGesture() before"
//        )
//    }
}
