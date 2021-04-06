//
//  Helpers.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import Foundation

enum WeatherConstant {
    
    enum Strings {
        static let latitude = "LAT"
        static let longitude = "LON"
        static let units = "UNITS"
        static let tempUnits = "Temp Units"
        
        static let title = "Weather"
        static let error = "Error"
        
        static let notificationTitle = "Weather Update"
        static let notificationBody = "from Weather assistant, currenlty its %@, plan accordingly"
        
        static let temperature = "Temp: "
        static let wind = "Wind: "
        static let description = "Desc: "

    }
    
    enum Units {
        static let celcius = "°C"
        static let fahrenheit = "°F"
    }
    
    enum Image {
        static let apple = "applelogo"
    }
    
    enum DateFormatter {
        static let format = "MMM dd yyyy"
        static let localeId = "en_US"
    }
}
