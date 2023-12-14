//
//  SaveViewModel.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 05/12/2023.
//

import Foundation

import Combine

class SaveViewModel: ObservableObject {
    @Published var saveResults: [CurrentWeatherResponse] = []
    private var cancellables: Set<AnyCancellable> = []
    private let databaseAdapter = DatabaseAdapter.shared
    
    init() {
        getAllWeatherData()
    }
    
    func getAllWeatherData() {
        databaseAdapter.getAllWeathers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] results in
                // Handle the received results
                self?.saveResults = results
            })
            .store(in: &cancellables)
    }
    
}
