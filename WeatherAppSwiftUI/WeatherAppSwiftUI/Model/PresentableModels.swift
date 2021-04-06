//
//  PresentableModels.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import Foundation
import Combine

enum TempUnits: String {
    case celsius = "°C"
    case fahrenheit = "°F"
}

struct PresentableWeatherData: Identifiable {
    let dailyWeather: [PresentableDaily]
    let currenWeather: Current
    
    var id: String {
        return UUID().uuidString
    }
    
    init(weather: WeatherData) {
        var dailyArray = [PresentableDaily]()
        for daily in weather.daily {
            dailyArray.append(PresentableDaily(daily: daily))
        }
        self.dailyWeather = dailyArray
        self.currenWeather = weather.current
    }
}

struct PresentableDaily: Identifiable {
    let date: Date
    let minTemp: Double
    let maxTemp: Double
    let nightTemp: Double
    let eveTemp: Double
    let morTemp: Double
    let wind: Double
    let weatherDescription: String
    
    var id: String {
        return UUID().uuidString
    }
    
    var minTempWithUnits: String {
        guard let tempUnit = UserDefaults.standard.value(forKey: WeatherConstant.Strings.units) as? String, let tempUnitVal = TempUnits(rawValue: tempUnit) else { return String(format: "%0.0f L - %0.0f H", minTemp.celsius(), maxTemp.celsius()) }
        let tempInCelsius = String(format: "%0.0f L - %0.0f H", minTemp.celsius(), maxTemp.celsius())
        let tempInFahrenheit = String(format: "%0.0f L - %0.0f H", minTemp.fahrenheit(), maxTemp.fahrenheit())
        return tempUnitVal == .celsius ? tempInCelsius : tempInFahrenheit
    }
    
    var maxTempWithUnits: Double {
        guard let tempUnit = UserDefaults.standard.value(forKey: WeatherConstant.Strings.units) as? String, let tempUnitVal = TempUnits(rawValue: tempUnit) else { return maxTemp.celsius() }
        return tempUnitVal == .celsius ? maxTemp.celsius() : maxTemp.fahrenheit()
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: WeatherConstant.DateFormatter.localeId)
        dateFormatter.dateFormat = WeatherConstant.DateFormatter.format
        return dateFormatter.string(from: date)
    }
    
    init(daily: Daily) {
        self.date = daily.dt.asDate()
        self.minTemp = daily.temp.min
        self.maxTemp = daily.temp.max
        self.nightTemp = daily.temp.night
        self.morTemp = daily.temp.morn
        self.eveTemp = daily.temp.eve
        self.weatherDescription = daily.weather.first?.weatherDescription ?? ""
        self.wind = daily.windSpeed
    }
}

struct PresentableCurrent: Identifiable {
    let weather: [Weather]
    let humidity: Int
    var id: String {
        return UUID().uuidString
    }
}

struct PresentableTemp: Identifiable {
    let day, min, max, night, eve, morn: String
    var id: String {
        return UUID().uuidString
    }
}

struct PresentableFeelsLike: Identifiable {
    let day, night, eve, morn: String
    var id: String {
        return UUID().uuidString
    }
}
