//
//  NetworkAgent.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 05/12/2023.
//

import Foundation
import Combine

protocol NetworkAgent {
    func fetchWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<CurrentWeatherResponse, Error>
    func fetchForecastWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<ForeCastWeatherResponse, Error>
    
}
