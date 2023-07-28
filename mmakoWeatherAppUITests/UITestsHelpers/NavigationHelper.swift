import XCTest

let kOneSecondTimeout: TimeInterval = 1
let kTwoSecondTimeout: TimeInterval = 2
let kThreeSecondTimeout: TimeInterval = 3
let kFiveSecondTimeout: TimeInterval = 5
let kTenSecondTimeout: TimeInterval = 10
let kFifteenSecondTimeout: TimeInterval = 15

class NavigationHelper: XCTestCase {
    func navigateToHomeFromAppLaunch(testCase: XCTestCase) {
        let app = XCUIApplication()
        app.launch()
        allowLocationIfNeeded()
        waitForElementToAppear(test: testCase, element: app.staticTexts[WeatherAppStaticText.temperatureNowText.rawValue])
    }
    
    func navigateToHomeFromExtendedScreen() {
        XCUIApplication().tables.buttons[WeatherAppButton.doneButton.rawValue].tap()
    }
    
    func navigateToExtendedScreenFromHome() {
        XCUIApplication().staticTexts[WeatherAppButton.extendedButton.rawValue].tap()
    }
    
    func waitForElementToAppear(test: XCTestCase, element: XCUIElement, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true");
        test.expectation(for: existsPredicate, evaluatedWith: element, handler: nil);
        test.waitForExpectations(timeout: 5) {
            (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 5 seconds.";
                test.record(XCTIssue(type: .assertionFailure, compactDescription: message))
            }
        }
    }
    
    func allowLocationIfNeeded() {
        let systemAlerts = springBoardAppForSystemHandling.alerts
        if systemAlerts.buttons["Allow While Using App"].waitForExistence(timeout: kTwoSecondTimeout) {
            systemAlerts.buttons["Allow While Using App"].tap()
        }
    }
}

