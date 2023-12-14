//
//  WeatherAPIManager.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 04/12/2023.
//

import Foundation
import Combine

class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    init() {}
    
    func fetchWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<CurrentWeatherResponse, Error> {
        let urlString = "\(AppConstants.baseURL)weather?lat=\(latitude)&lon=\(longitude)&appid=\(AppConstants.apiKey)"
        return fetch(urlString: urlString)
    }

    func fetchForecastWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<ForeCastWeatherResponse, Error> {
        let urlString = "\(AppConstants.baseURL)onecall?lat=\(latitude)&lon=\(longitude)&appid=\(AppConstants.apiKey)&exclude=current,minutely,hourly,alerts&cnt=5"
        return fetch(urlString: urlString)
    }

    
    func fetchAutocompleteResults(_ query: String) -> AnyPublisher<[SearchResult], Error> {
        let urlString = "\(AppConstants.searchCityURL)\(query)"
        return fetch(urlString: urlString)
    }
    
    private func fetch<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        print("urlString ===>  \(urlString)")
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
