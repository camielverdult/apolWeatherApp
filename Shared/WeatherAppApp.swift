//
//  WeatherAppApp.swift
//  Shared
//
//  Created by Camiel Verdult on 10/12/2021.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var network = Network()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
