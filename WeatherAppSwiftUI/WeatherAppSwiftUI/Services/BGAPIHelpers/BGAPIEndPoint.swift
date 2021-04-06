//
//  BGAPIEndPoint.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import Foundation

struct API {
    static let baseUrl = "http://api.openweathermap.org/"
    static let version = "data/2.5/"
    static let weatherPath = "onecall"
    static let appIdKey = "appid"
    static let appId = "331fc0c7b422365e594b67341c728c82"
}

class BGAPIEndPoint {
    
    var baseUrl: String {
        return API.baseUrl
    }
    
    var path: String {
        return API.weatherPath
    }
    
    var params: String {
        return ""
    }
    
    var appid: String {
        return "?\(API.appIdKey)=\(API.appId)"
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
    
    var apiVersion: String {
        return API.version
    }
    
    var onlyDaily: String {
        return "&exclude=hourly,minutely"
    }
    
    var url : String {
        return baseUrl + apiVersion + path + appid + onlyDaily + params
    }
}

enum HttpMethod :String {
    case post = "POST"
    case get = "GET"
}
