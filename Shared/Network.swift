//
//  Network.swift
//  WeatherApp
//
//  Created by Camiel Verdult on 15/12/2021.
//

import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var weatherData: [WeatherData] = []
    var parsed: [PointParsed] = []

    func getWeatherpoints() {
        guard let url = URL(string: "https://keepersofweather.nl/api") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                
                print("Got weatherpoints")
                
                guard let data = data else { return }
                print("Decoding JSON...")
                DispatchQueue.main.async {
                    do {
                        let decodedWeatherpoints = try JSONDecoder().decode([PointParsed].self, from: data)
                        self.parsed = decodedWeatherpoints
                    } catch let error {
                        print("Error decoding weaterpoints: ", error)
                    }
                    
                    print("Parsed \(self.parsed.count) weather points")
                    
                    let parser = LocationParser()
                    
                    print("Getting locations...")
                    
                    parser.getLocations()
                    
                    print("Rebuilding to WeatherData with unique id...")
                    
                    for point in self.parsed {
                        
                        var locationForWeatherpoint = Location(City: "Earth", deviceID: "lht-mars", deviceIndex: 0)
                        
                        for location in parser.locations {
                            if (location.deviceID == point.metadata.deviceID) {
                                locationForWeatherpoint = location
                            }
                        }
                        
                        let metadataWithLocation = MetadataExtra(utcTimeStamp: point.metadata.utcTimeStamp, deviceID: point.metadata.deviceID, applicationID: point.metadata.applicationID, gatewayID: point.metadata.gatewayID, LocationData: locationForWeatherpoint)
                        
                        let newPoint = WeatherData(id: UUID(), metadata: metadataWithLocation, positional: point.positional, sensorData: point.sensorData, transmissionalData: point.transmissionalData)
                        
                        self.weatherData.append(newPoint)
                    }
                }
            }
        }
        
        print("Resuming JSON parsing task...")

        dataTask.resume()
    
    }
}
