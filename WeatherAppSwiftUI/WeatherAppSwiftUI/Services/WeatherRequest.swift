//
//  WeatherRequest.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 05/04/2021.
//

import Foundation

struct WeatherRequest: APIRequestType {
    
    typealias Response = WeatherData
    
    var queryParams: [String : String]
    
    init(_ params: [String: String]) {
        queryParams = params
    }
    var path: String { return "/data/2.5/onecall" }
    var queryItems: [URLQueryItem]? {
        return queryParams.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
}
