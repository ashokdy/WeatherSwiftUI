//
//  APIServiceErrorTest.swift
//  WeatherAppSwiftUITests
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import XCTest
@testable import WeatherAppSwiftUI

class APIServiceErrorTest: XCTestCase {
    
    let systemUnderTest = APIServiceError.networkError
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIServiceError() {
        XCTAssertEqual(systemUnderTest.localizedDescription, "Network is not available, please try again later.")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
