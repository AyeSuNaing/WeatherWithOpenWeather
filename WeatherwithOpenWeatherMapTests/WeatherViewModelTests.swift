//
//  WeatherViewModelTests.swift
//  WeatherwithOpenWeatherMapTests
//
//  Created by Brycen on 12/5/23.
//

import Foundation
import XCTest
import Combine
@testable import WeatherwithOpenWeatherMap


class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        viewModel = WeatherViewModel()
    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }

    
        func testFetchWeatherAndForecast() {
            // Given
            let expectationWeather = expectation(description: "Current weather data is fetched")
            let expectationForecast = expectation(description: "Forecast data is fetched")

            // Simulate successful API responses
            let mockWeatherData = try! Data(contentsOf: WeatherMockData.WeatherListResult.weatherResultJsonUrl)
            let decoder = JSONDecoder()
            let mockWeatherResponse = try! decoder.decode(CurrentWeatherResponse.self, from: mockWeatherData)

            let mockForecastData = try! Data(contentsOf: ForecastMockData.ForecastListResult.forecastResultJsonUrl)
            let mockForecastResponse = try! decoder.decode(ForeCastWeatherResponse.self, from: mockForecastData)

            let apiManagerMock = WeatherAPIManagerMock(currentResponse: .success(mockWeatherResponse), forecastResponse: .success(mockForecastResponse))
            viewModel.weatherAPIManager = apiManagerMock

            // When
            viewModel.fetchWeather(latitude: 37.7858, longitude: -122.4064)
            viewModel.fetchForecastWeather(latitude: 37.7858, longitude: -122.4064)

            // Then
            viewModel.$state
                .dropFirst(2) // Ignore the initial idle state and two states from fetchWeather and fetchForecastWeather
                .sink { state in
                    switch state {
                    case .success:
                        if self.viewModel.currentWeather != nil {
                            expectationWeather.fulfill()
                        } else if self.viewModel.forecastList != nil {
                            expectationForecast.fulfill()
                        }
                    case .failure(let error):
                        XCTFail("Unexpected failure state: \(error.localizedDescription)")
                    default:
                        break
                    }
                }
                .store(in: &cancellables)

            wait(for: [expectationWeather, expectationForecast], timeout: 5)
        }

    func test_fetchWeatherList_returnlist_success_totalcount() {
        let expectationWeather = expectation(description: "Current weather data is fetched")
        let expectationForecast = expectation(description: "Forecast data is fetched")

        // Simulate successful API responses
        let mockWeatherData = try! Data(contentsOf: WeatherMockData.WeatherListResult.weatherResultJsonUrl)
        let decoder = JSONDecoder()
        let mockWeatherResponse = try! decoder.decode(CurrentWeatherResponse.self, from: mockWeatherData)

        let mockForecastData = try! Data(contentsOf: ForecastMockData.ForecastListResult.forecastResultJsonUrl)
        let mockForecastResponse = try! decoder.decode(ForeCastWeatherResponse.self, from: mockForecastData)

        let apiManagerMock = WeatherAPIManagerMock(currentResponse: .success(mockWeatherResponse), forecastResponse: .success(mockForecastResponse))
        viewModel.weatherAPIManager = apiManagerMock

        viewModel.fetchWeather(latitude: 37.7858, longitude: -122.4064)
        viewModel.fetchForecastWeather(latitude: 37.7858, longitude: -122.4064)

        let cancellable = viewModel.$forecastList
            .dropFirst(1)
            .sink { resultList in
                // Safely unwrap the optional before accessing its properties
                if let resultList = resultList {
                    XCTAssertEqual(resultList.daily?.count, 8)
                    expectationForecast.fulfill()
                } else {
                    XCTFail("Unexpected nil value for forecastList")
                }
            }
        
        let weatherCancellable = viewModel.$currentWeather
            .dropFirst(1)
            .sink { weather in
                // Safely unwrap the optional before accessing its properties
                if let result = weather {
                    XCTAssertEqual(result.name, "San Francisco")
                    expectationForecast.fulfill()
                } else {
                    XCTFail("Unexpected nil value for forecastList")
                }
            }

        wait(for: [expectationWeather, expectationForecast], timeout: 5)

        // Cancel the sink to avoid potential memory leaks
        cancellable.cancel()
        weatherCancellable.cancel()
    }

    
    
}
