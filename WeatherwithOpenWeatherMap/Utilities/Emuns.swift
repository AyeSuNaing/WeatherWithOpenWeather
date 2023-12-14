//
//  Emuns.swift
//  WeatherwithOpenWeatherMap
//
//  Created by Brycen on 12/4/23.
//

import Foundation


enum WeatherCondition {
    case thunderstorm
    case drizzle
    case rain
    case snow
    case atmosphere
    case clear
    case clouds
    case unknown

    init(conditionCode: Int) {
        switch conditionCode {
        case 200...299: self = .thunderstorm
        case 300...399: self = .drizzle
        case 500...599: self = .rain
        case 600...699: self = .snow
        case 700...799: self = .atmosphere
        case 800: self = .clear
        case 801...899: self = .clouds
        default: self = .unknown
        }
    }
}


enum WeatherState {
    case idle
    case loading
    case success
    case failure(Error)
}


