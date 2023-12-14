//
//  CurrentWeatherResponse.swift
//  WeatherwithOpenWeatherMap
//
//  Created by Brycen on 12/4/23.
//

import Foundation
import RealmSwift


// MARK: - CurrentWeatherResponse
struct CurrentWeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
    
    func toCurrentWeatherResposeDBO () -> CurrentWeatherResponseDBO {
        let dbo =  CurrentWeatherResponseDBO()
        dbo.coord = coord?.toDBO()
        weather?.forEach({weat in
            dbo.weather.append(weat.toDBO())
        })
        dbo.base = base
        dbo.main = main?.toDBO()
        dbo.visibility = visibility ?? 0
        dbo.wind = wind?.toDBO()
        dbo.clouds = clouds?.toDBO()
        dbo.dt = dt ?? 0
        dbo.sys = sys?.toDBO()
        dbo.timezone = timezone ?? 0
        dbo.id = id ?? 0
        dbo.name = name ?? ""
        dbo.cod = cod ?? 0
        return dbo
        
        
    }
    
}


// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
    func toDBO() -> CloudsDBO {
        let dbo = CloudsDBO()
        dbo.all = all ?? 0
        return dbo
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
    
    func toDBO () -> CoordDBO {
        let dbo = CoordDBO()
        dbo.lat = lat ?? 0.0
        dbo.lon = lon ?? 0.0
        return dbo
    }
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
    
    func toDBO () -> MainDBO {
        let dbo = MainDBO()
        dbo.temp = temp ?? 0.0
        dbo.feelsLike = feelsLike ?? 0.0
        dbo.tempMin = tempMin ?? 0.0
        dbo.tempMax = tempMax ?? 0.0
        dbo.pressure = pressure ?? 0
        dbo.humidity = humidity ?? 0
        return dbo
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
    
    func toDBO () -> SysDBO {
        let dbo = SysDBO()
        dbo.type = type ?? 0
        dbo.id = id ?? 0
        dbo.country = country ?? ""
        dbo.sunset = sunset  ?? 0
        dbo.sunrise = sunrise  ?? 0
        return dbo
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
    
    func toDBO () -> WeatherDBO {
        let dbo = WeatherDBO()
        dbo.id = id  ?? 0
        dbo.main = main ?? ""
        dbo.weatherDescription = description ?? ""
        dbo.icon = icon ?? ""
        return dbo
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
    func toDBO () -> WindDBO {
        let dbo = WindDBO()
        dbo.speed = speed ?? 0.0
        dbo.deg = deg ?? 0
        dbo.gust = gust ?? 0.0
        return dbo
    }
}

