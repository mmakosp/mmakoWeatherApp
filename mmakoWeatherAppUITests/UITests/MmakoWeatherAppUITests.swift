import XCTest

class mmakoWeatherAppUITests: XCTestCase {
    private let launchHelper = AppUITestNavigationHelper()
    private let navigationHelper = NavigationHelper()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIAmAbleToSeeHomeScreen() {
        navigationHelper.navigateToHomeFromAppLaunch(testCase: self)
    }
    
    func testGivenIAmAbleToLanuchApp_whenAppIsLaunched_thenIAmableToSeeCurrentTemperature() {
        navigationHelper.navigateToHomeFromAppLaunch(testCase: self)
        testVerification.verifyStaticTextExists(staticTextToVerify: .currentTemperature)
    }
    
    func testGivenIAmAbleToLanuchApp_whenAppIsLaunched_thenIAmableToSeeScreenTitle() {
        navigationHelper.navigateToHomeFromAppLaunch(testCase: self)
        testVerification.verifyStaticTextExists(staticTextToVerify: .temperatureNowText)
    }
    
    func testGivenIAmAbleToLanuchApp_whenAppIsLaunched_thenIAmableToSeeMinimumTemperature() {
        navigationHelper.navigateToHomeFromAppLaunch(testCase: self)
        testVerification.verifyStaticTextExists(staticTextToVerify: .minimumTemperature)
    }
    
    func testGivenIAmAbleToLanuchApp_whenAppIsLaunched_thenIAmableToSeeMaximumTemperature() {
        navigationHelper.navigateToHomeFromAppLaunch(testCase: self)
        testVerification.verifyStaticTextExists(staticTextToVerify: .maximumTemperature)
    }
    
    func testGivenIAmAbleToLanuchApp_whenAppIsLaunched_thenIAmableToSeeCurrentTemperatureDescription() {
        navigationHelper.navigateToHomeFromAppLaunch(testCase: self)
        testVerification.verifyStaticTextExists(staticTextToVerify: .currentTemperatureDescription)
    }
    
    func testGivenIAmAbleToLanuchApp_whenAppIsLaunched_thenIAmableToSeeExtendedForecastButton() {
        navigationHelper.navigateToHomeFromAppLaunch(testCase: self)
        testVerification.verifyAppButtonTitle(buttonToVerify: .extendedButton)
    }
}
