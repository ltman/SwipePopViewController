import XCTest

@testable
import SwipePopViewController

class SwipePopNavigationControllerDelegateTests: XCTestCase {
    func testInteractionControllerFor() {
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let navigationController = UINavigationControllerMock()
        let swipePopDelegate = SwipePopNavigationControllerDelegate(viewControllerDelegate: secondViewController)
        let animatedTransitionMock = UIViewControllerAnimatedTransitioningMock()
        navigationController.delegate = navigationController
        navigationController.viewControllers = [firstViewController, secondViewController]
        secondViewController.panGestureRecognizer = PanGestureBeganStateMock()
        let percentDrivenInteractiveTransitionResult = swipePopDelegate.navigationController(navigationController, interactionControllerFor: animatedTransitionMock)
        
        XCTAssertTrue(navigationController.delegate === secondViewController.selfNavigationControllerDelegate)
        XCTAssertNotNil(percentDrivenInteractiveTransitionResult)
    }
}
