//
//  ForecastMockData.swift
//  WeatherwithOpenWeatherMapTests
//
//  Created by Brycen on 12/5/23.
//

import Foundation
import UIKit
@testable import WeatherwithOpenWeatherMap

public final class ForecastMockData {
    
    class ForecastListResult{
        public static let forecastResultJsonUrl : URL = Bundle(for: ForecastMockData.self).url(forResource: "forecast_weather", withExtension: "json")!
    }
    
    
}
