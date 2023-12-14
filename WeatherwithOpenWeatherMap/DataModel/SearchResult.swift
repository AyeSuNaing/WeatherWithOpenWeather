//
//  SearchResult.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 04/12/2023.
//

import Foundation


struct SearchResult: Identifiable, Decodable {
    let id = UUID()
    let placeId: Int?
    let licence: String?
    let osmType: String?
    let osmId: Int?
    let latitude: String?
    let longitude: String?
    let classType: String?
    let entityType: String?
    let placeRank: Int?
    let importance: Double?
    let addressType: String?
    let name: String?
    let displayName: String?
    let boundingBox: [String]?

    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case licence
        case osmType = "osm_type"
        case osmId = "osm_id"
        case latitude = "lat"
        case longitude = "lon"
        case classType = "class"
        case entityType = "type"
        case placeRank = "place_rank"
        case importance
        case addressType = "addresstype"
        case name
        case displayName = "display_name"
        case boundingBox
    }
}
