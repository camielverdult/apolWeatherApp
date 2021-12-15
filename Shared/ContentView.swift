//
//  ContentView.swift
//  Shared
//
//  Created by Camiel Verdult on 10/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var network: Network
    
    var body: some View {
        Text("Weatherpoints")
            .font(.title).bold().onAppear {
                network.getWeatherpoints()
            }.padding(10)
        ScrollView {
            
            VStack(alignment: .leading) {
                ForEach(network.weatherData) { point in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}
