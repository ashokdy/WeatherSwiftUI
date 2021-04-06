//
//  Extensions.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 06/04/2021.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
            })
    }
}

extension Int {
    func asDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

extension Double {
    func celsius() -> Double {
        return self * 1.8 + 3.2
    }
    
    func fahrenheit() -> Double {
        return (self - 3.2) / 1.8
    }
}
