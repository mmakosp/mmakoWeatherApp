import XCTest

class UITestVerificationImplementation {
    
    func assertThatISeeStaticTextInCellExists(withText text: String, delay: Double = kTwoSecondTimeout) {
        let element = XCUIApplication().cells.containing(.cell, identifier: text).staticTexts.element(boundBy: 0)
        if (element.waitForExistence(timeout: delay)) {
            XCTAssertTrue(true)
        } else {
            XCTFail("Failed to find \(element) after \(kTwoSecondTimeout) seconds.")
        }
    }
    
    func assertThatISeeScreenTitle(screenTitle: WeatherAppNavigationBarTitle) {
        XCTAssertTrue(XCUIApplication().tables.staticTexts[screenTitle.rawValue].exists)
    }
    
    func assertThatISeeTableStaticText(staticTextToVerify: WeatherAppStaticText) {
        XCTAssertTrue(XCUIApplication().tables.staticTexts[staticTextToVerify.rawValue].waitForExistence(timeout: kFiveSecondTimeout))
    }
    
    func assertThatISeeStaticText(staticTextToVerify: WeatherAppStaticText) {
        XCTAssertTrue(XCUIApplication().staticTexts[staticTextToVerify.rawValue].waitForExistence(timeout: kFiveSecondTimeout))
    }
    
    func assertThatISeeAppButton(buttonToVerify: WeatherAppButton) {
        XCTAssertTrue(XCUIApplication().buttons[buttonToVerify.rawValue].waitForExistence(timeout: kFiveSecondTimeout))
    }
    
    func assertThatISeeStaticButton(buttonToVerify: WeatherAppButton) {
        XCTAssertTrue(XCUIApplication().buttons.staticTexts[buttonToVerify.rawValue].waitForExistence(timeout: kFiveSecondTimeout))
    }
    
    func assertThatIDoNotSeeTheCellText(staticTextToVerify: WeatherAppStaticText) {
        XCTAssertFalse(XCUIApplication().tables.staticTexts[staticTextToVerify.rawValue].waitForExistence(timeout: kTwoSecondTimeout))
    }
    
    func assertThatISeeWebView() {
        XCTAssertTrue(XCUIApplication().buttons[WeatherAppButton.urlButton.rawValue].waitForExistence(timeout: kFiveSecondTimeout))
    }
    
    func assertThatISeeLocationPopUpButton(buttonToVerify: WeatherAppButton) {
        XCTAssertTrue(XCUIApplication().alerts["Allow “mmakoWeatherApp” to use your location?"].scrollViews.otherElements.buttons["Don’t Allow"].waitForExistence(timeout: kFiveSecondTimeout))
    }
    
    func assertThatISeeNoLocationPopUpButton(buttonToVerify: WeatherAppButton) {
        XCTAssertFalse(springBoardAppForSystemHandling.alerts.buttons[buttonToVerify.rawValue].waitForExistence(timeout: kFiveSecondTimeout))
    }
    
    func assertThatISeeNoNotificationPopUp() {
        XCTAssertTrue(springBoardAppForSystemHandling.alerts.buttons[WeatherAppButton.whileUsingButton.rawValue].waitForExistence(timeout: kFiveSecondTimeout))
    }
    
    func assertThatISeeExtendedStaticText(staticTextToVerify: WeatherAppExtendedWeekdaysText) {
        XCTAssertTrue(XCUIApplication().tables.cells.staticTexts[staticTextToVerify.rawValue].waitForExistence(timeout: kFiveSecondTimeout))
    }
    
    func assertThatISeeExtendedStaticTextWithCells(weekdayText: WeatherAppExtendedWeekdaysText, temperatureText: String) {
        XCTAssertTrue(XCUIApplication().cells.containing(.staticText, identifier: weekdayText.rawValue).staticTexts[temperatureText].waitForExistence(timeout: kFiveSecondTimeout))
    }
}
