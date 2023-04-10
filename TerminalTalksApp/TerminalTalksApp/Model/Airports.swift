//
//  Airports.swift
//  TerminalTalksApp
//
//  Created by Sebastian Guiscardo on 4/8/23.
//   let airports = try? JSONDecoder().decode(Airports.self, from: jsonData)

import Foundation
//fix the model so that it can be called from airport search bar

// MARK: - Airport
struct Airport: Codable {
    let name: String
    let city: String
    let country: String
    let iataCode: String
    let geoloc: Geoloc
    let linksCount: Int
    let objectID: String

    enum CodingKeys: String, CodingKey {
        case name, city, country
        case iataCode = "iata_code"
        case geoloc = "_geoloc"
        case linksCount = "links_count"
        case objectID
    }
}

// MARK: - Geoloc
struct Geoloc: Codable {
    let lat, lng: Double
}

