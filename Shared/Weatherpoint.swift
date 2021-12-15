//
//  Weatherpoint.swift
//  WeatherApp
//
//  Created by Camiel Verdult on 15/12/2021.
//

import Foundation

struct WeatherData: Identifiable {
    let id: UUID
    let metadata: MetadataExtra
    let positional: Positional
    let sensorData: SensorData
    let transmissionalData: TransmissionalData
}

struct PointParsed: Codable {
    let metadata: Metadata
    let positional: Positional
    let sensorData: SensorData
    let transmissionalData: TransmissionalData
}

struct MetadataExtra: Codable {
    let utcTimeStamp, deviceID, applicationID, gatewayID: String
    let LocationData: Location
}

// MARK: - Metadata
struct Metadata: Codable {
    let utcTimeStamp, deviceID, applicationID, gatewayID: String
}

// MARK: - Positional
struct Positional: Codable {
    let latitude, longitude: Double?
    let altitude: Int?
}

// MARK: - SensorData
struct SensorData: Codable {
    let lightLogscale: Int?
    let lightLux: Int?
    let temperature: Double
    let humidity: Float?
    let pressure: Float?
    let batteryStatus: Int?
    let batteryVoltage: Float?
    let workMode: String?
}

// MARK: - TransmissionalData
struct TransmissionalData: Codable {
    let rssi: Int?
    let snr: Double?
    let spreadingFactor: Int?
    let consumedAirtime: Double?
    let bandwidth, frequency: Int?
}
