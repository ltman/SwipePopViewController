import XCTest

@testable
import SwipePopViewController

class SwipePopNavigationControllerDelegateTests: XCTestCase {
    func testInteractionControllerFor() {
        let firstViewController = UIViewController()
        let secondViewController = UIViewController()
        let originalNavigationControllerDelegate: UINavigationControllerDelegate = NavigationControllerDelegateMock()
        let navigationController = UINavigationControllerMock()
        let swipePopDelegate = SwipePopNavigationControllerDelegate(viewControllerDelegate: secondViewController)
        let animatedTransitionMock = UIViewControllerAnimatedTransitioningMock()
        secondViewController.selfNavigationControllerDelegate = originalNavigationControllerDelegate
        navigationController.viewControllers = [firstViewController, secondViewController]
        secondViewController.panGestureRecognizer = PanGestureRecognizerMock(mockState: .began, mockVelocity: CGPoint(x: 10, y: 0), mockTranslation: CGPoint(x: 0, y: 0))
        let percentDrivenInteractiveTransitionResult = swipePopDelegate.navigationController(navigationController, interactionControllerFor: animatedTransitionMock)
        
        XCTAssertTrue(navigationController.delegate === originalNavigationControllerDelegate)
        XCTAssertNotNil(percentDrivenInteractiveTransitionResult)
    }
}
