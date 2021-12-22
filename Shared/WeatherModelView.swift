//
//  ContentView.swift
//  Shared
//
//  Created by Camiel Verdult on 10/12/2021.
//

import SwiftUI

struct WeatherpointScrollView: View {
    
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
                    .background(Color.accentColor.opacity(0.3))
                    .cornerRadius(20)
                }
            }.padding(20)
        }
    }
}

struct WeatherModelView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherpointScrollView()
            .environmentObject(ApiFriend())
    }
}
