import XCTest

class AppUITestNavigationHelper: XCTestCase {
    private let navigationHelper = NavigationHelper()

    func givenIAmAbleToLaunchApp() {
        let app = XCUIApplication()
        app.launch()
    }
}

