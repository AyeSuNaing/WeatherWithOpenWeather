//
//  WeatherAPIManagerMock.swift
//  WeatherwithOpenWeatherMapTests
//
//  Created by Brycen on 12/5/23.
//

import Foundation
import XCTest
import Combine
@testable import WeatherwithOpenWeatherMap



class WeatherAPIManagerMock: WeatherAPIManager {
    var currentResponse: Result<CurrentWeatherResponse, Error>
    var forecastResponse: Result<ForeCastWeatherResponse, Error>

    init(currentResponse: Result<CurrentWeatherResponse, Error>, forecastResponse: Result<ForeCastWeatherResponse, Error>) {
        self.currentResponse = currentResponse
        self.forecastResponse = forecastResponse
        super.init()
    }

    override func fetchWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<CurrentWeatherResponse, Error> {
        return Just(try! currentResponse.get())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    override func fetchForecastWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<ForeCastWeatherResponse, Error> {
        return Just(try! forecastResponse.get())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
