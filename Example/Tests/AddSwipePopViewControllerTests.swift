import XCTest

@testable
import SwipePopViewController

class AddSwipePopViewControllerTests: XCTestCase {
    func testSwipePopNotAvailableInFirstViewController() {
        let mockSwipeViewController = UIViewController()
        _ = UINavigationController(rootViewController: mockSwipeViewController)
        mockSwipeViewController.addSwipeBackGesture()
        XCTAssertNil(mockSwipeViewController.panGestureRecognizer)
    }
    
    func testSwipePopAvailableInSecondViewController() {
        let mockFirstSwipeViewController = UIViewController()
        let mockSecondSwipeViewController = UIViewController()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [mockFirstSwipeViewController, mockSecondSwipeViewController]
        mockSecondSwipeViewController.addSwipeBackGesture()
        XCTAssertNotNil(mockSecondSwipeViewController.panGestureRecognizer)
    }
    
    func testAddSwipePopDouble() {
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [firstViewController, secondViewController]
        secondViewController.addSwipeBackGesture()
        secondViewController.addSwipeBackGesture()
        XCTAssertEqual(secondViewController.view.gestureRecognizers!.count, 1)
    }
}
