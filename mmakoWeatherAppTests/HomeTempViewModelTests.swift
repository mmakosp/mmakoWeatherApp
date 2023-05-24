//
//  HomeTempViewModelTests.swift
//  mmakoWeatherAppTests
//
//  Created by Mmako Sekhosana on 2023/05/23.
//

import Foundation
import XCTest
@testable import mmakoWeatherApp

class HomeTempViewModelTests: XCTestCase {
    func testCurrentMood() {
        var weather: [Weather] = []
        let cloudyWeather = Weather(id: 2, description: "Cloudy", main: .clouds)
        weather.append(cloudyWeather)
        let weatherData = WeatherData(name: "Pretoria",
                                      main: WeatherMain(temperature: 290,
                                                        humidity: 16,
                                                        tempMin: 278,
                                                        tempMax: 299),
                                      weather: weather)
        let forecastData = ForecastData(list: [])
        let homeTempModel = HomeTempModel(currentWeather: weatherData, futureCast: forecastData)
        let viewModel = HomeTempViewModel(with: homeTempModel)
        XCTAssertEqual(viewModel.currentMood, "Cloudy")
    }
    
    func testCurrentTemperature() {
        let weather: [Weather] = []
        let weatherData = WeatherData(name: "Pretoria",
                                      main: WeatherMain(temperature: 300,
                                                        humidity: 16,
                                                        tempMin: 278,
                                                        tempMax: 299),
                                      weather: weather)
        let forecastData = ForecastData(list: [])
        let homeTempModel = HomeTempModel(currentWeather: weatherData, futureCast: forecastData)
        let viewModel = HomeTempViewModel(with: homeTempModel)
        XCTAssertEqual(viewModel.currentTemp, "27°")
    }
    
    func testMaxTemperature() {
        let weather: [Weather] = []
        let weatherData = WeatherData(name: "Pretoria",
                                      main: WeatherMain(temperature: 300,
                                                        humidity: 16,
                                                        tempMin: 278,
                                                        tempMax: 299),
                                      weather: weather)
        let forecastData = ForecastData(list: [])
        let homeTempModel = HomeTempModel(currentWeather: weatherData, futureCast: forecastData)
        let viewModel = HomeTempViewModel(with: homeTempModel)
        XCTAssertEqual(viewModel.maxTemp, "26°")
    }
    
    func testMinimumTemperature() {
        let weather: [Weather] = []
        let weatherData = WeatherData(name: "Pretoria",
                                      main: WeatherMain(temperature: 300,
                                                        humidity: 16,
                                                        tempMin: 278,
                                                        tempMax: 299),
                                      weather: weather)
        let forecastData = ForecastData(list: [])
        let homeTempModel = HomeTempModel(currentWeather: weatherData, futureCast: forecastData)
        let viewModel = HomeTempViewModel(with: homeTempModel)
        XCTAssertEqual(viewModel.minTemp, "5°")
    }
    
    func testMinimumDegreesDescription() {
        let weather: [Weather] = []
        let weatherData = WeatherData(name: "Pretoria",
                                      main: WeatherMain(temperature: 300,
                                                        humidity: 16,
                                                        tempMin: 278,
                                                        tempMax: 299),
                                      weather: weather)
        let forecastData = ForecastData(list: [])
        let homeTempModel = HomeTempModel(currentWeather: weatherData, futureCast: forecastData)
        let viewModel = HomeTempViewModel(with: homeTempModel)
        XCTAssertEqual(viewModel.minDegreesDescription, "min")
    }
    
    func testMaxDegreesDescription() {
        let weather: [Weather] = []
        let weatherData = WeatherData(name: "Pretoria",
                                      main: WeatherMain(temperature: 300,
                                                        humidity: 16,
                                                        tempMin: 278,
                                                        tempMax: 299),
                                      weather: weather)
        let forecastData = ForecastData(list: [])
        let homeTempModel = HomeTempModel(currentWeather: weatherData, futureCast: forecastData)
        let viewModel = HomeTempViewModel(with: homeTempModel)
        XCTAssertEqual(viewModel.maxDegreesDescription, "max")
    }
}
