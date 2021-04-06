//
//  WeatherResponseTest.swift
//  WeatherAppSwiftUITests
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import XCTest
@testable import WeatherAppSwiftUI

class WeatherResponseTest: XCTestCase {
    
    let expectedcod: String? = "some"
    let expectedmessage: Int? = 12
    let expectedcnt: Int? = 23
    
    var systemUnderTest: WeatherData!
    var systemUnderSecondTest: PresentableWeatherData!
    let idString = UUID().uuidString
    private let inPutData = Data("""
{
  "lat": 33.4418,
  "lon": -94.0377,
  "timezone": "America/Chicago",
  "timezone_offset": -18000,
  "current": {
    "dt": 1617648299,
    "sunrise": 1617623876,
    "sunset": 1617669549,
    "temp": 297.32,
    "feels_like": 297.02,
    "pressure": 1019,
    "humidity": 47,
    "dew_point": 285.31,
    "uvi": 6.11,
    "clouds": 90,
    "visibility": 10000,
    "wind_speed": 4.63,
    "wind_deg": 200,
    "weather": [
      {
        "id": 804,
        "main": "Clouds",
        "description": "overcast clouds",
        "icon": "04d"
      }
    ]
  },
  "daily": [
    {
      "dt": 1617645600,
      "sunrise": 1617623876,
      "sunset": 1617669549,
      "temp": {
        "day": 297.32,
        "min": 286.07,
        "max": 297.32,
        "night": 288.62,
        "eve": 293.24,
        "morn": 286.07
      },
      "feels_like": {
        "day": 297.02,
        "night": 285.74,
        "eve": 293.18,
        "morn": 285.74
      },
      "pressure": 1019,
      "humidity": 47,
      "dew_point": 285.31,
      "wind_speed": 4.2,
      "wind_deg": 183,
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "overcast clouds",
          "icon": "04d"
        }
      ],
      "clouds": 90,
      "pop": 0,
      "uvi": 8.1
    }
]
}
""".utf8)
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = WeatherData(lat: 12.344546, lon: 25.3445, timezone: "UTC", current: Current(dt: 1234, sunrise: 234, sunset: 77, temp: 67, feelsLike: 7676, pressure: 767, humidity: 767, dewPoint: 767, uvi: 767, clouds: 76, visibility: 65, windSpeed: 565, windDeg: 56, weather: [Weather(id: 87, main: "Cloudy", weatherDescription: "Go out and enjoy", icon: "Apple Logo")]), daily: [Daily(dt: 767, sunrise: 76, sunset: 76, temp: Temp(day: 343, min: 565, max: 656, night: 656, eve: 65, morn: 78), feelsLike: FeelsLike(day: 65, night: 65, eve: 98, morn: 76), pressure: 098, humidity: 767, dewPoint: 65, windSpeed: 545, windDeg: 45, weather: [Weather(id: 786, main: "Weather mai", weatherDescription: "Raining inside out", icon: "")], clouds: 878, pop: 7, uvi: 6, rain: 656)])
        systemUnderSecondTest = PresentableWeatherData(weather: systemUnderTest)
    }
    
    func testDecoding_whenMissingType_itThrows() throws {
        AssertThrowsKeyNotFound("current", decoding: WeatherData.self, from: try inPutData.json(deletingKeyPaths: "current"))
    }
    
    func testDecoding_whenMissingAttributes_itThrows() throws {
        AssertThrowsKeyNotFound("daily", decoding: WeatherData.self, from: try inPutData.json(deletingKeyPaths: "daily"))
    }
    
    func testDecoding_WhenAllOK() throws {
        let _ = try JSONDecoder().decode(WeatherData.self, from: inPutData)
        XCTAssertTrue(true)
    }
    
    func testSUT_InitializesId() {
        XCTAssertNotEqual(systemUnderSecondTest.id, idString)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

func AssertThrowsKeyNotFound<T: Decodable>(_ expectedKey: String, decoding: T.Type, from data: Data, file: StaticString = #file, line: UInt = #line) {
    XCTAssertThrowsError(try JSONDecoder().decode(decoding, from: data), file: file, line: line) { error in
        if case .keyNotFound(let key, _)? = error as? DecodingError {
            XCTAssertEqual(expectedKey, key.stringValue, "Expected missing key '\(key.stringValue)' to equal '\(expectedKey)'.", file: file, line: line)
        } else {
            XCTFail("Expected '.keyNotFound(\(expectedKey))' but got \(error)", file: file, line: line)
        }
    }
}

extension Data {
    func json(deletingKeyPaths keyPaths: String...) throws -> Data {
        let decoded = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as AnyObject
        
        for keyPath in keyPaths {
            decoded.setValue(nil, forKeyPath: keyPath)
        }
        
        return try JSONSerialization.data(withJSONObject: decoded)
    }
}
