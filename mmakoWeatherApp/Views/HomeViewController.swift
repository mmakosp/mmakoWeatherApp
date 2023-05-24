//
//  ViewController.swift
//  mmakoWeatherApp
//
//  Created by Mmako Sekhosana on 2023/05/21.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    private var currentWeather: WeatherData?
    private var forecastWeather: ForecastData?
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    private func setupLocationRequest() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func getWeather(latitude: Double, longitude: Double) {
        WeatherDataSource.fetchCurrentWeather(latitude: latitude, longitude: longitude, apiKey: Config.APP_ID) { result in
            switch result {
            case .success(let weatherData):
                self.currentWeather = weatherData
            case .failure(_):
                self.currentWeather = nil
            }
        }
        
        WeatherDataSource.fetchForecastData(latitude: latitude, longitude: longitude, apiKey: Config.APP_ID) { [self] result in
            switch result {
            case .success(let weatherData):
                self.forecastWeather = weatherData
                DispatchQueue.main.async {
                    self.showHomeAlert(currentWeather: self.currentWeather, forecastWeather: self.forecastWeather)
                }
            case .failure(_):
                self.forecastWeather = nil
            }
        }
    }
    
    func showHomeAlert(currentWeather: WeatherData?, forecastWeather: ForecastData?) {
        let alertController = UIAlertController(title: "Weather based on location", message: "Tap OK to continue", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
            guard let self = self else { return }
            
            if let currentWeather = currentWeather, let forecastWeather = forecastWeather {
                let homeTempModel = HomeTempModel(currentWeather: currentWeather, futureCast: forecastWeather)
                let homeTableViewController = HomeTableViewController(viewModel: HomeTempViewModel(with: homeTempModel))
                homeTableViewController.navigationController?.navigationBar.isHidden = true
                homeTableViewController.modalPresentationStyle = .fullScreen
                self.present(homeTableViewController, animated: true, completion: nil)
            }
        }
        
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Location Manager
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        getWeather(latitude: latitude, longitude: longitude)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handleErrorAlert(error: error)
    }
    
    private func handleErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Location Error", message: error.localizedDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
}
