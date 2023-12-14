//
//  WeatherViewModel.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 04/12/2023.
//

import Foundation
import CoreLocation
import Combine

class WeatherViewModel:  NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var currentWeather: CurrentWeatherResponse?
    @Published var forecastList: ForeCastWeatherResponse?
    @Published var state: WeatherState = .loading
    
    private var cancellables: Set<AnyCancellable> = []
    private let locationManager = CLLocationManager()
    
    var weatherAPIManager: WeatherAPIManager = WeatherAPIManager.shared

    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        state = .loading
        
        guard let location = locations.last else {
            return
        }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        fetchForecastWeather(latitude: latitude, longitude: longitude)
        fetchWeather(latitude: latitude, longitude: longitude)
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
        state = .failure(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    func fetchWeather(latitude: Double, longitude: Double) {
        weatherAPIManager.fetchWeatherData(latitude: latitude, longitude: longitude)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .success
                case .failure(let error):
                    self?.state = .failure(error)
                    print("Error fetching current weather: \(error.localizedDescription)")
                }}, receiveValue: { [weak self] weatherData in
                    self?.currentWeather = weatherData
                    DatabaseAdapter.shared.saveCurrentWeather(weather: weatherData.toCurrentWeatherResposeDBO())
                })
            .store(in: &cancellables)
    }
    
    func fetchForecastWeather(latitude: Double, longitude: Double) {
        weatherAPIManager.fetchForecastWeatherData(latitude: latitude, longitude: longitude)
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .success
                case .failure(let error):
                    self?.state = .failure(error)
                    print("Error fetching current weather: \(error.localizedDescription)")
                } }, receiveValue: { [weak self] forecastData in
                    self?.forecastList = forecastData
                })
            .store(in: &cancellables)
    }
}
