//
//  WeatherViewModel_Tests.swift
//  WeatherAppSwiftUITests
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import XCTest
import Combine
@testable import WeatherAppSwiftUI

class WeatherViewModel_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func testInitializeObject() {
//        let forecast = WeatherViewModel(apiService: APIService())
//        XCTAssertTrue(forecast.forecast.count == 0)
//    }
//    
//    func testSinkReceiveDataThenError() {
//        // setup
//        let forecast = WeatherViewModel(apiService: APIService())
//        
//        _ = forecast.$isErrorShown.sink { (value) in
//            XCTAssertNotNil(value)
//            XCTAssertEqual(value, false)
//        }
//        
//        _ = forecast.$errorMessage.sink { (value) in
//            XCTAssertNotNil(value)
//            XCTAssertEqual(value, "")
//        }
//        
//        _ = forecast.$isLoading.sink { (value) in
//            XCTAssertNotNil(value)
//            XCTAssertEqual(value, true)
//        }
//        
//    }
}
