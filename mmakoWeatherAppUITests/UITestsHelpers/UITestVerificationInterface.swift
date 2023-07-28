class UITestVerificationInterface {
    
    func verifyStaticTextInCellExists(staticTextToVerify : String) {
        testAssert.assertThatISeeStaticTextInCellExists(withText: staticTextToVerify)
    }
    
    func verifyStaticTextExists(staticTextToVerify : WeatherAppStaticText) {
        testAssert.assertThatISeeStaticText(staticTextToVerify: staticTextToVerify)
    }
    
    func verifyTableStaticTextExists(staticTextToVerify : WeatherAppStaticText) {
        testAssert.assertThatISeeTableStaticText(staticTextToVerify: staticTextToVerify)
    }
    
    func verifyScreenTitle(screenToVerify : WeatherAppNavigationBarTitle) {
        testAssert.assertThatISeeScreenTitle(screenTitle: screenToVerify)
    }
    
    func verifyAppButtonTitle(buttonToVerify : WeatherAppButton) {
        testAssert.assertThatISeeAppButton(buttonToVerify: buttonToVerify)
    }
    
    func verifyStaticButtonTitle(buttonToVerify : WeatherAppButton) {
        testAssert.assertThatISeeStaticButton(buttonToVerify: buttonToVerify)
    }
    
    func verifyThatISeeWebView() {
        testAssert.assertThatISeeWebView()
    }
    
    func verifyThatISeeLocationPopUp() {
        testAssert.assertThatISeeLocationPopUpButton(buttonToVerify: .whileUsingButton)
    }
    
    func verifyThatISeeNoLocationPopUp() {
        testAssert.assertThatISeeNoNotificationPopUp()
    }
    
    func verifyStaticTextExistsInExtendedScreen() {
        testAssert.assertThatISeeExtendedStaticTextWithCells(weekdayText: .sundayDescription, temperatureText: "19°")
    }
}
