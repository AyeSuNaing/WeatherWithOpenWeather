//
//  SearchViewModel.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 04/12/2023.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [SearchResult] = []

    private var cancellables: Set<AnyCancellable> = []

    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.fetchAutocompleteResults(searchText)
            }
            .store(in: &cancellables)
    }

    func fetchAutocompleteResults(_ query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }

        WeatherAPIManager.shared.fetchAutocompleteResults(query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Handle successful completion if needed
                    break
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] results in
                self?.searchResults = results
            })
            .store(in: &cancellables)
    }
}
