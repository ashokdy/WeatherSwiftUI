//
//  WeatherDataTest.swift
//  WeatherAppSwiftUITests
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import XCTest
@testable import WeatherAppSwiftUI

class WeatherDataTest: XCTestCase {
    
    let expectedLat: Double = 12.344546
    let expectedLong: Double = 25.3445
    let weather = Weather(id: 786, main: "Weather main", weatherDescription: "Raining inside out", icon: "")
    let feelsLike = FeelsLike(day: 65, night: 65, eve: 98, morn: 76)
    let temp = Temp(day: 343, min: 565, max: 656, night: 656, eve: 65, morn: 78)
    let current = Current(dt: 1234, sunrise: 234, sunset: 77, temp: 67, feelsLike: 7676, pressure: 767, humidity: 767, dewPoint: 767, uvi: 767, clouds: 76, visibility: 65, windSpeed: 565, windDeg: 56, weather: [Weather(id: 87, main: "Cloudy", weatherDescription: "Go out and enjoy", icon: "Apple Logo")])
    let daily = Daily(dt: 767, sunrise: 76, sunset: 76, temp: Temp(day: 343, min: 565, max: 656, night: 656, eve: 65, morn: 78), feelsLike: FeelsLike(day: 65, night: 65, eve: 98, morn: 76), pressure: 098, humidity: 767, dewPoint: 65, windSpeed: 545, windDeg: 45, weather: [Weather(id: 786, main: "Weather main", weatherDescription: "Raining inside out", icon: "")], clouds: 878, pop: 7, uvi: 6, rain: 656)
    
    let weatherData = WeatherData(lat: 12.344546, lon: 25.3445, timezone: "UTC", current: Current(dt: 1234, sunrise: 234, sunset: 77, temp: 67, feelsLike: 7676, pressure: 767, humidity: 767, dewPoint: 767, uvi: 767, clouds: 76, visibility: 65, windSpeed: 565, windDeg: 56, weather: [Weather(id: 87, main: "Cloudy", weatherDescription: "Go out and enjoy", icon: "Apple Logo")]), daily: [Daily(dt: 767, sunrise: 76, sunset: 76, temp: Temp(day: 343, min: 565, max: 656, night: 656, eve: 65, morn: 78), feelsLike: FeelsLike(day: 65, night: 65, eve: 98, morn: 76), pressure: 098, humidity: 767, dewPoint: 65, windSpeed: 545, windDeg: 45, weather: [Weather(id: 786, main: "Weather main", weatherDescription: "Raining inside out", icon: "")], clouds: 878, pop: 7, uvi: 6, rain: 656)])
    
    var systemUnderTest: WeatherData!
    
    override func setUp() {
        super.setUp()
        
        systemUnderTest = WeatherData(lat: expectedLat, lon: expectedLong, timezone: "UTC", current: current, daily: [daily])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_InitializesLat() {
        XCTAssertEqual(systemUnderTest.lat, expectedLat)
    }
    
    func test_InitializesDaily() {
        XCTAssertNotNil(systemUnderTest.daily)
        XCTAssert(systemUnderTest.daily.count == [daily].count)
    }
    
    func test_InitializesCurrennTimeZone() {
        XCTAssertNotNil(systemUnderTest.timezone)
        XCTAssert(systemUnderTest.current.dt == current.dt)
    }
    
    func test_InitializesWeather() {
        XCTAssertNotNil(systemUnderTest.current.weather.first?.weatherDescription)
        XCTAssert(systemUnderTest.current.weather.count == [weather].count)
    }
    
    func testFeelsLikeDay() {
        XCTAssertEqual(systemUnderTest.daily.first?.feelsLike.day, 65)
        XCTAssertNotEqual(systemUnderTest.daily.first?.feelsLike.day, 6545)
    }
}
