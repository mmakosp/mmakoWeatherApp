import XCTest
import Foundation

class TerminateHelper {
    
    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    let settings = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
    
    /**
     Terminate and delete the app via springboard
     */
    static func deleteMyApp() {
        XCUIApplication().terminate()
        
        // Resolve the query for the springboard rather than launching it
        springboard.activate()
        
        // Rotate back to Portrait, just to ensure repeatability here
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait
        // Sleep to let the device finish its rotation animation, if it needed rotating
        sleep(2)
        
        // Force delete the app from the springboard
        // Handle iOS 11 iPad 'duplication' of icons (one nested under "Home screen icons" and the other nested under "Multitasking Dock"
        let icon = springboard.icons["mmakoWeatherApp"]
        if icon.exists {
            let iconFrame = icon.frame
            let springboardFrame = springboard.frame
            icon.press(forDuration: 2.5)
            
            // Tap the little "X" button at approximately where it is. The X is not exposed directly
            springboard.coordinate(withNormalizedOffset: CGVector(dx: ((iconFrame.minX + 3) / springboardFrame.maxX), dy:((iconFrame.minY + 3) / springboardFrame.maxY))).tap()
            // Wait some time for the animation end
            Thread.sleep(forTimeInterval: 0.5)
            
            //springboard.alerts.buttons["Delete"].firstMatch.tap()
            springboard.buttons["Delete App"].firstMatch.tap()
            Thread.sleep(forTimeInterval: 0.5)
            springboard.buttons["Delete"].firstMatch.tap()
            
            // Press home once make the icons stop wiggling
            XCUIDevice.shared.press(.home)
            // Press home again to go to the first page of the springboard
            XCUIDevice.shared.press(.home)
            // Wait some time for the animation end
            Thread.sleep(forTimeInterval: 0.5)
        }
    }
}
