//
//  WeatherAppApp.swift
//  Watch WatchKit Extension
//
//  Created by Camiel Verdult on 04/01/2022.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
