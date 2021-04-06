//
//  WeatherViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 05/04/2021.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    private var cancellables: [AnyCancellable] = []
    private let responseSubject = PassthroughSubject<WeatherData, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let onGetLocSubject = PassthroughSubject<Void, Never>()
    
    // MARK: Output
    @Published private(set) var forecast = [PresentableWeatherData]()
    @Published var isErrorShown = false
    @Published var isLoading = true
    @Published var errorMessage = ""
    //    @State var dailyData: [Daily]?
    
    private let apiService: APIServiceType
    private let locationManager = LocationManager()
    
    // MARK: Initialzer
    init(apiService: APIServiceType = APIService()) {
        self.apiService = apiService
        getLocation()
        bindOutputs()
    }
    
    // MARK: Helper
    private func getLocation() {
        let subscriber = locationManager.objectWillChange.sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                self.errorSubject.send(error)
            case .finished: break
            }
        }) { (str) in
            
        }
        let placeholderSubs = locationManager.$placemark.sink { (placeMark) in
            if let _ = placeMark?.locality {
                self.bindInputs(currentLoc: self.locationManager.location?.coordinate)
                self.onGetLocSubject.send(())
            }
        }
        cancellables.append(subscriber)
        cancellables.append(placeholderSubs)
    }
    private func bindInputs(currentLoc: CLLocationCoordinate2D?) {
        let lat = String(format: "%f", currentLoc?.latitude ?? 25.2048)
        let lon = String(format: "%f", currentLoc?.longitude ?? 55.2708)
        let params = ["lat": lat, "lon": lon, "appid": Environment.API_KEY, "exclude": "hourly,minutely", "units": "metric"]
        
        let request = WeatherRequest(params)
        let responsePublisher = onGetLocSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request)
                    .catch { [weak self] error -> Empty<WeatherData, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }
        
        let responseStream = responsePublisher
            //  .share()
            .subscribe(responseSubject)
        
        cancellables += [
            responseStream
        ]
    }
    
    private func bindOutputs() {
        let repositoriesStream = responseSubject
            .map {
                self.isLoading = false
                return WeatherViewModel.getPresentableData(($0))
            }
            .assign(to: \.forecast, on: self)
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                error.localizedDescription
            }
            .assign(to: \.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map{ error -> Bool in
                self.isLoading = false
                return true
            }.receive(on: RunLoop.main)
            .assign(to: \.isErrorShown, on: self)
        
        cancellables += [
            repositoriesStream,
            errorStream,
            errorMessageStream
        ]
    }
    
    // MARK: Data Transformer
    private static func getPresentableData(_ forecastRes: WeatherData) -> [PresentableWeatherData] {
        return [PresentableWeatherData(weather: forecastRes)]
    }
}
