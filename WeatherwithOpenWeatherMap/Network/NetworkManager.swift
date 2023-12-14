//
//  NetworkManager.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 05/12/2023.
//

import Foundation

import Combine

class NetworkManager {
    
    static let shared = NetworkManager() 
    
    private init() {}
    
    func fetch<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        print(urlString)
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

