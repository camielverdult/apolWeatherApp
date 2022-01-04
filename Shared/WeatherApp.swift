//
//  WeatherAppApp.swift
//  Shared
//
//  Created by Camiel Verdult on 10/12/2021.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var apiFriend: ApiFriend = ApiFriend()
    
    init() {
        apiFriend.initialise()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(apiFriend)
        }
    }
}
