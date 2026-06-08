//
//  CampusModels.swift
//  HansungBoogi
//
//  Created by kim on 6/8/26.
//

import Foundation

enum PlaceCategory {
    case room
    case cafe
    case office
    case facility
}

enum AccessSide {
    case left
    case right
    case both
}

struct Place {
    let id: Int
    let name: String
    let category: PlaceCategory
    let accessSide: AccessSide
    let guideText: String
}

struct Building {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let places: [Place]
}
