//
//  CurrentWeatherResponseDBO.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 05/12/2023.
//

import Foundation
import RealmSwift

// MARK: - WeatherDBO
class WeatherDBO: Object {
    @Persisted var id: Int = 0
    @Persisted dynamic var main: String?
    @Persisted dynamic var weatherDescription: String?
    @Persisted dynamic var icon: String?
    
    func toWeather() -> Weather {
        return Weather(id: self.id, main: self.main, description: self.description, icon: self.icon)
    }
}

// MARK: - CoordDBO
class CoordDBO: Object {
    @Persisted dynamic var lon: Double = 0.0
    @Persisted dynamic var lat: Double = 0.0
    
    func toCoord() -> Coord {
        return Coord(lon: self.lat, lat: self.lon)
    }
    
}

// MARK: - MainDBO
class MainDBO: Object {
    @Persisted dynamic var temp: Double = 0.0
    @Persisted dynamic var feelsLike: Double = 0.0
    @Persisted dynamic var tempMin: Double = 0.0
    @Persisted dynamic var tempMax: Double = 0.0
    @Persisted dynamic var pressure: Int = 0
    @Persisted dynamic var humidity: Int = 0
    
    func toMain() -> Main {
        return Main(temp: self.temp, feelsLike: self.feelsLike, tempMin: self.tempMin, tempMax: self.tempMax, pressure: self.pressure, humidity: self.humidity)
    }
}

// MARK: - SysDBO
class SysDBO: Object {
    @Persisted dynamic var type: Int = 0
    @Persisted dynamic var id: Int = 0
    @Persisted dynamic var country: String?
    @Persisted dynamic var sunrise: Int = 0
    @Persisted dynamic var sunset: Int = 0
    
    func toSys() -> Sys {
        return Sys(type: self.type, id: self.id, country: self.country, sunrise: self.sunrise, sunset: self.sunset)
    }
}

// MARK: - CloudsDBO
class CloudsDBO: Object {
    @Persisted dynamic var all: Int = 0
    
    func toClud() -> Clouds {
        return Clouds(all: self.all )
    }
}

// MARK: - WindDBO
class WindDBO: Object {
    @Persisted dynamic var speed: Double = 0.0
    @Persisted dynamic var deg: Int = 0
    @Persisted dynamic var gust: Double = 0.0
    
    func toWind() -> Wind {
        return Wind(speed: self.speed, deg: self.deg, gust: self.gust)
    }
    
}

// MARK: - CurrentWeatherResponseDBO
class CurrentWeatherResponseDBO: Object {
    @Persisted var coord: CoordDBO?
    @Persisted var weather: List<WeatherDBO> = List<WeatherDBO>()
    @Persisted dynamic var base: String?
    @Persisted var main: MainDBO?
    @Persisted dynamic var visibility: Int = 0
    @Persisted var wind: WindDBO?
    @Persisted var clouds: CloudsDBO?
    @Persisted dynamic var dt: Int = 0
    @Persisted var sys: SysDBO?
    @Persisted dynamic var timezone: Int = 0
    @Persisted (primaryKey: true) dynamic var id: Int = 0
    @Persisted dynamic var name: String?
    @Persisted dynamic var cod: Int = 0

    func toCurrentWeatherResponse () -> CurrentWeatherResponse {
        return CurrentWeatherResponse(coord: self.coord?.toCoord(), weather: weather.map({weatherDBO in weatherDBO.toWeather() }), base: base, main: main?.toMain(), visibility: visibility, wind: wind?.toWind(), clouds: clouds?.toClud(), dt: dt, sys: sys?.toSys(), timezone: timezone, id: id, name: name, cod: cod)
    }
}


