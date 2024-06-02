//
//  Model.swift
//  URLSession
//
//  Created by Shinhyuk on 2024/06/02.
//

import Foundation

struct Results: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let origin, location: Location
    let image: String
    let episode: [String]
}

struct Location: Codable {
    let name: String
    let url: String
}
