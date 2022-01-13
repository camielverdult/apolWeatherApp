//
//  ContentView.swift
//  WeatherApp
//
//  Created by Camiel Verdult on 18/12/2021.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    @EnvironmentObject var apiFriend: ApiFriend
    @State var tabIndex: Int = 0
    
    let rows = [
            GridItem(.fixed(30))
        ]
    
    var body: some View {
        
        TabView(selection: $tabIndex) {
            
            LazyHGrid(rows: rows, spacing: 100) {
                ForEach(apiFriend.getCities()) { city in
                    LineChartView(data: apiFriend.getTemperatures(forCity: city), title: "Temperature in \(city.name) today (ºC)", rateValue: 1)
                }
            }.tag(0)
            
            VStack {
                Text("Weatherpoints")
                    .font(.title).bold().padding(10)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(apiFriend.weatherData) { point in
                            HStack(alignment:.top) {
                                Text("\(point.metadata.LocationData.City)").bold()

                                VStack(alignment: .leading) {
                                    Text(point.metadata.deviceID)
                                    Text(point.metadata.utcTimeStamp)
                                    Text(String(format: "Temperature: %.2fº C", point.sensorData.temperature))
                                }
                            }
                            .frame(width: 300, alignment: .leading)
                            .padding()
                            .background(Color.accentColor.opacity(0.3))
                            .cornerRadius(20)
                        }
                    }.padding(20)
                }
            }.tag(1)
            
        }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
