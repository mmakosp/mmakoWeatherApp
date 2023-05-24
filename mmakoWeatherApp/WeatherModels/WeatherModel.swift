//
//  File.swift
//  mmakoWeatherApp
//
//  Created by Mmako Sekhosana on 2023/05/21.
//

import Foundation
import UIKit
struct WeatherData: Codable {
    var name: String
    var main: WeatherMain
    var weather: [Weather]
}

struct WeatherMain: Codable {
    var temperature: Double
    var humidity: Int
    var tempMin: Double
    var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
        case tempMin
        case tempMax
    }
}

struct Weather: Codable {
    var id: Int
    var description: String
    var main: WeatherIcon
}

enum WeatherIcon: String, Codable {
    case rain = "Rain"
    case clouds = "Clouds"
    case clear = "Clear"
    case unowned

    var iconImage: UIImage {
        switch self {
        case .rain: return UIImage(named: "rain") ?? UIImage()
        case .clouds: return UIImage(named: "partlysunny") ?? UIImage()
        case .clear: return UIImage(named: "clear")  ?? UIImage()
        default: return UIImage(named: "clear")  ?? UIImage()
        }
    }
}

struct ForecastData: Codable {
    var list: [Forecast]
}

struct Forecast: Codable {
    var dt: Int
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    var temp: Double
    var humidity: Int
}
