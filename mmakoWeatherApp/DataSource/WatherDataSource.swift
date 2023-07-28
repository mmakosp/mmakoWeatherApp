//
//  WatherDataSource.swift.swift
//  mmakoWeatherApp
//
//  Created by Mmako Sekhosana on 2023/05/21.
//

import Foundation
class WeatherDataSource {
    static func fetchCurrentWeather(latitude: Double, longitude: Double, apiKey: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(Config.WEATHER_URL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            DispatchQueue.global().async {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let weatherData = try decoder.decode(WeatherData.self, from: data)
                    
                    
                    DispatchQueue.main.async {
                        completion(.success(weatherData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    static func fetchCurrentWeatherFromLocalFile(fileName: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])))
            return
        }

        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let weatherData = try decoder.decode(WeatherData.self, from: data)

            completion(.success(weatherData))
        } catch {
            completion(.failure(error))
        }
    }
    
    static func fetchForecastData(latitude: Double, longitude: Double, apiKey: String, completion: @escaping (Result<ForecastData, Error>) -> Void) {
        let urlString = "\(Config.FORECAST_URL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let forecastData = try decoder.decode(ForecastData.self, from: data)
                completion(.success(forecastData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    static func fetchForecastDataFromLocalFile(fileName: String, completion: @escaping (Result<ForecastData, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])))
            return
        }

        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let forecastData = try decoder.decode(ForecastData.self, from: data)

            completion(.success(forecastData))
        } catch {
            completion(.failure(error))
        }
    }
}
