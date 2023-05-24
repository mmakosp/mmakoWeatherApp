//
//  HomeTempViewModel.swift
//  mmakoWeatherApp
//
//  Created by Mmako Sekhosana on 2023/05/21.
//

import Foundation
import UIKit

struct HomeTempModel {
    var currentWeather: WeatherData
    var futureCast: ForecastData
}

enum Weekday: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
}

enum DayOfWeek: String {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case unknown = "Unknown"
}


class HomeTempViewModel {
    var model: HomeTempModel
    let degreeSymbol = "\u{00B0}"
    var weatherDayData: [String: Forecast] = [:]

    // MARK: - Init

    init(with model: HomeTempModel) {
        self.model = model
    }
    
    var currentMood: String {
        return model.currentWeather.weather[0].description
    }
    
    var currentTemp: String {
        return String(format: "%.0f", model.currentWeather.main.temperature - 273.15) + "\(degreeSymbol)"
    }
    
    var currentDescription: String {
       return "Current"
    }
    
    var minTemp: String {
        return String(format: "%.0f", model.currentWeather.main.tempMin - 273.15) + "\(degreeSymbol)"
    }

    var minDegreesDescription: String {
        return "min"
    }
    
    var maxTemp: String {
        return String(format: "%.0f", model.currentWeather.main.tempMax - 273.15) + "\(degreeSymbol)"
    }
    
    var maxDegreesDescription: String {
        return "max"
    }
    
    private func getDayOfTheWeek(timeStamp: Int) -> DayOfWeek {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        switch weekday {
        case 1:
            return .sunday
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        case 7:
            return .saturday
        default:
            return .unknown
        }
    }
    
    func getWeatherDay() -> [String: Forecast] {
        var dayWeatherDict: [String: Forecast] = [:]

        for item in model.futureCast.list {
            let timeStamp = item.dt
            let dayOfWeek = getDayOfTheWeek(timeStamp: timeStamp)
            let dayString = dayOfWeek.rawValue
            
            if !dayWeatherDict.keys.contains(dayString) {
                dayWeatherDict[dayString] = item
            }
        }
        return dayWeatherDict
    }
}
