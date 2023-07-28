import XCTest

enum WeatherAppBarCellIdentifier: String {
    case investDetailsRequestDocIdentifier = "INVEST_DETAILS_REQUEST_DOCUMENT_CELL"
}

enum WeatherAppButton: String {
    case doneButton = "Done"
    case extendedButton = "See extended temperatures"
    case urlButton = "URL"
    case whileUsingButton = "Allow While Using App"
    case allowOnceButton = "Allow Once"
    case dontAllow = "Don’t Allow"
}

enum WeatherAppNavigationBarTitle: String {
    case extendedTitle = "Extended Forecast"
}

enum WeatherAppAlerts: String {
    case alertLocationTitle = "Allow “mmakoWeatherApp” to use your location?"
}

enum WeatherAppStaticText: String {
    case temperatureNowText = "Temperature now"
    case currentTemperature = "17°C"
    case minimumTemperature = "Min 13°C"
    case maximumTemperature = "Max 25°C"
    case currentTemperatureDescription = "Current 17°C"
}

enum WeatherAppExtendedStaticText: String {
    case temperatureDescription = "scattered clouds"
    case currentTemperature = "17°"
    case minimumTemperature = "13°"
    case maximumTemperature = "25°"
    case currentTemperatureDescription = "Current"
    case minimumTemperatureDescription = "min°"
    case maximumTemperatureDescription = "max"
}

enum WeatherAppExtendedTemperatureDescription: String {
    case currentTemperatureDescription = "Current"
    case minimumTemperatureDescription = "min°"
    case maximumTemperatureDescription = "max"
}


enum WeatherAppExtendedWeekdaysText: String {
    case sundayDescription = "Sunday"
    case fridayDescription = "Friday"
    case thursdayDescription = "Thursday"
    case saturdayDescription = "Saturday"
    case tuesdayDescription = "Tuesday"
}


let testAssert = UITestVerificationImplementation()
let navigationHelper = NavigationHelper()
let appUITestNavigationHelper = AppUITestNavigationHelper()
let testVerification = UITestVerificationInterface()
let springBoardAppForSystemHandling = XCUIApplication(bundleIdentifier: "com.apple.springboard")
