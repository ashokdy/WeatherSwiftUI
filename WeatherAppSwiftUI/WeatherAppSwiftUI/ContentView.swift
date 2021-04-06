//
//  ContentView.swift
//  WeatherAppSwiftUI
//
//  Created by Ashok Devangam Yerra on 05/04/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var showDetail = false
    @State private var favoriteColor = 0
    @StateObject var settings = AppSettings()
    @State private var refresh = false
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $viewModel.isLoading) {
                List(viewModel.forecast.first?.dailyWeather ?? []) { item in
                    NavigationLink(destination: WeatheDetailView(daily: item)) {
                        WeatherCell(daily: item, needsRefresh: $refresh)
                    }
                }
                .listStyle(GroupedListStyle())
                .alert(isPresented: self.$viewModel.isErrorShown, content: { () -> Alert in
                    Alert(title: Text(WeatherConstant.Strings.error), message: Text(self.viewModel.errorMessage))
                })
            }
            .navigationBarTitle(Text(WeatherConstant.Strings.title), displayMode: .inline)
            .navigationBarItems(trailing: button)
        }.environmentObject(settings)
    }
    
    var button: some View {
        VStack {
            Picker(WeatherConstant.Strings.tempUnits, selection: $favoriteColor.onChange(segmentChanged(_:)), content: {
                Text(WeatherConstant.Units.celcius).tag(0)
                Text(WeatherConstant.Units.fahrenheit).tag(1)
            })
            .pickerStyle(SegmentedPickerStyle()) // <1>
        }
    }
    
    func segmentChanged(_ selectedIndex: Int) {
        let unitValue = selectedIndex == 0 ? WeatherConstant.Units.celcius : WeatherConstant.Units.fahrenheit
        UserDefaults.standard.setValue(unitValue, forKey: WeatherConstant.Strings.units)
        settings.units = unitValue
        refresh = true
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
#endif
