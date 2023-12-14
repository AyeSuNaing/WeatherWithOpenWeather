//
//  WeatherMockData.swift
//  WeatherwithOpenWeatherMapTests
//
//  Created by Brycen on 12/5/23.
//

import Foundation
import UIKit
@testable import WeatherwithOpenWeatherMap

public final class WeatherMockData {
    
    class WeatherListResult{
        public static let weatherResultJsonUrl : URL = Bundle(for: WeatherMockData.self).url(forResource: "current_weather", withExtension: "json")!
    }
    
    
}
