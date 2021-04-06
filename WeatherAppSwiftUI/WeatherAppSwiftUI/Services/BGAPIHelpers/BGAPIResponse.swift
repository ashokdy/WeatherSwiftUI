//
//  BGAPIResponse.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import Foundation

struct BGAPIResponse {
    
    let data: Data
    var statusCode:Int = -100
    
    init(data: Data) {
        self.data = data
    }
    
    func getModel<T:Codable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self.data)
    }
}
