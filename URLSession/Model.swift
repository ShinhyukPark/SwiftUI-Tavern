//
//  Model.swift
//  URLSession
//
//  Created by Shinhyuk on 2024/06/02.
//

import Foundation

struct Characters: Codable {
    let results: [Results]
}

struct Results: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}
