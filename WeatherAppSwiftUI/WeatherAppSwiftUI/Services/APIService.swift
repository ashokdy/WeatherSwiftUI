//
//  APIService.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 05/04/2021.
//

import Foundation
import Combine

struct Environment {
    static let BASE_URL = "http://api.openweathermap.org"
    static let API_KEY = "331fc0c7b422365e594b67341c728c82"
}

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryParams: [String: String] { get set }
    var queryItems: [URLQueryItem]? { get }
}

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
}

final class APIService: APIServiceType {
    
    private let baseURL: URL
    init(baseURL: URL = URL(string: Environment.BASE_URL)!) {
        self.baseURL = baseURL
    }

    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType {
    
        let pathURL = URL(string: request.path, relativeTo: baseURL)!
        
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decorder = JSONDecoder()
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, urlResponse in data }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: Request.Response.self, decoder: decorder)
            .mapError(APIServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
