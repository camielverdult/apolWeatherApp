//
//  Location.swift
//  WeatherApp
//
//  Created by Camiel Verdult on 15/12/2021.
//

import Foundation

class LocationParser {
    var locations: [Location] = []

    func getLocations() {
        guard let url = URL(string: "https://keepersofweather.nl/api/locations") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            print("Asking API for locations...")

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                
                print("Got locations from API, parsing...")
                
                guard let data = data else { return }
                
                print("Decoding location JSON...")
                do {
                    let decodedLocations = try JSONDecoder().decode([Location].self, from: data)
                    self.locations = decodedLocations
                } catch let error {
                    print("Error decoding locations: ", error)
                }
            }
        }
        
        dataTask.resume()
    }
}

/*
        [
            {
                "City" : "Enschede",
                "deviceId: py-saxion,
                "deviceIndex" : 1
            },
            ...
        ]
    */

struct Location: Codable {
    let City: String
    let deviceID: String
    let deviceIndex: Int
}
