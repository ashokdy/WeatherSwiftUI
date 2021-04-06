//
//  BGWeatherRequest.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import Foundation

class BGWeatherRequest: BGAPIEndPoint {
    
    var latitude: Double?
    var longitude: Double?
    
    override var params: String {
        return "&lat=\(latitude ?? 0)&lon=\(longitude ?? 0)"
    }
    
    init(_ latitude: Double, _ longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
