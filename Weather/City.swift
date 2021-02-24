//
//  City.swift
//  Weather
//
//  Created by Alexander Kononok on 2/24/21.
//

import Foundation

class City: Codable {
    var id: Int
    var name: String
    var state: String
    var coord: Coordinates
}
