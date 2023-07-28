import XCTest

class ExtendedWeatherAppUITests: XCTestCase {
    private let launchHelper = AppUITestNavigationHelper()
    private let navigationHelper = NavigationHelper()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGivenAppLaunched_whenTappingExtendedButton_thenISeeExtendedScreen() {
        navigationHelper.navigateToHomeFromAppLaunch(testCase: self)
        navigationHelper.navigateToExtendedScreenFromHome()
        testVerification.verifyScreenTitle(screenToVerify: .extendedTitle)
    }
    
    func testGivenAppLaunched_whenTappingExtendedButton_thenISee() {
        navigationHelper.navigateToHomeFromAppLaunch(testCase: self)
        navigationHelper.navigateToExtendedScreenFromHome()
        testVerification.verifyStaticTextExistsInExtendedScreen()
    }
}
