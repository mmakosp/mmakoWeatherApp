//
//  ViewController.swift
//  mmakoWeatherApp
//
//  Created by Mmako Sekhosana on 2023/05/21.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet private weak var currentTemperatureBigLabel: UILabel!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var currentDescTempLabel: UILabel!
    @IBOutlet private weak var MinTempLabel: UILabel!
    @IBOutlet private weak var currentSmallTempLabel: UILabel!
    @IBOutlet private weak var MaxTempLabel: UILabel!
    @IBOutlet private weak var showFutureButton: UIButton!
    
    private var currentWeather: WeatherData?
    private var forecastWeather: ForecastData?
    private let locationManager = CLLocationManager()
    let degreeSymbol = "\u{00B0}"
    let homeTextColor = UIColor.systemCyan
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFutureButton.isHidden = true
        setupLocationRequest()
        applyStyling()
    }
    
    private func applyStyling() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            self.currentTempLabel.text = "Current " + String(format: "%.0f", (currentWeather?.main.temperature ?? 273.15) - 273.15) + "\(degreeSymbol)" + "C"
            self.currentTempLabel.textColor = homeTextColor
            self.MinTempLabel.text = "Min " + String(format: "%.0f", (currentWeather?.main.tempMin ?? 273.15) - 273.15) + "\(degreeSymbol)" + "C"
            self.MinTempLabel.textColor = homeTextColor
            self.MaxTempLabel.text = "Max " + String(format: "%.0f", (currentWeather?.main.tempMax ?? 273.15) - 273.15) + "\(degreeSymbol)" + "C"
            self.MaxTempLabel.textColor = homeTextColor
            self.currentDescTempLabel.text = "Temperature now"
            self.currentDescTempLabel.textColor = homeTextColor
            self.currentTemperatureBigLabel.text = String(format: "%.0f", (currentWeather?.main.temperature ?? 273.15) - 273.15) + "\(degreeSymbol)" + "C"
            self.currentTemperatureBigLabel.textColor = homeTextColor
            self.showFutureButton.tintColor = .systemIndigo
            showFutureButton.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func setupLocationRequest() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func getWeather(with latitude: Double, longitude: Double) {
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
        if isUITesting {
            getLocalFileWeatherData()
        } else {
            guard let location = locations.last else { return }
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            getWeather(with: latitude, longitude: longitude)
            locationManager.stopUpdatingLocation()
        }
    }
    
    private func getLocalFileWeatherData() {
        WeatherDataSource.fetchCurrentWeatherFromLocalFile(fileName: "currentWeather") { result in
            switch result {
            case .success(let weatherData):
                self.currentWeather = weatherData
            case .failure(_):
                self.currentWeather = nil
            }
        }
        
        WeatherDataSource.fetchForecastDataFromLocalFile(fileName: "forecastWeather") { result in
            switch result {
            case .success(let weatherData):
                self.forecastWeather = weatherData
            case .failure(_):
                self.forecastWeather = nil
            }
        }
    }
    
    private var isUITesting: Bool {
        if let keyToCheck = ProcessInfo.processInfo.environment["TMPDIR"] {
            return keyToCheck.contains("XCTestDevices")
        }
        return false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if !isUITesting {
            handleErrorAlert(error: error)
        }
    }
    
    private func handleErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Location Error", message: error.localizedDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showFutureButtonTapped(_ sender: Any) {
        DispatchQueue.main.async { [self] in
            if let currentWeather = currentWeather, let forecastWeather = forecastWeather {
                let homeTempModel = HomeTempModel(currentWeather: currentWeather, futureCast: forecastWeather)
                let homeTableViewController = HomeTableViewController(viewModel: HomeTempViewModel(with: homeTempModel))
                homeTableViewController.navigationController?.navigationBar.isHidden = true
                homeTableViewController.modalPresentationStyle = .fullScreen
                self.present(homeTableViewController, animated: true, completion: nil)
            }
        }
    }
    
}
