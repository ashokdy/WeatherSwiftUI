//
//  WeatherAppSwiftUIApp.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 05/04/2021.
//

import SwiftUI

@main
struct WeatherAppSwiftUIApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: WeatherViewModel(apiService: APIService()))
        }
    }
}
