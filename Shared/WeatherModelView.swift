//
//  ContentView.swift
//  Shared
//
//  Created by Camiel Verdult on 10/12/2021.
//

import SwiftUI

struct WeatherModelView: View {
    
    @EnvironmentObject var apiFriend: ApiFriend
    
    var body: some View {
        Text("Weatherpoints")
            .font(.title).bold().onAppear {
                apiFriend.buildWeatherPoints()
            }.padding(10)
        
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
                    .background(Color(#colorLiteral(red: 0.6667672396, green: 0.7527905703, blue: 1, alpha: 0.2662717301)))
                    .cornerRadius(20)
                }
            }
        }
    }
}

struct WeatherModelView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherModelView()
            .environmentObject(ApiFriend())

    }
}
