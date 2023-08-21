//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by Sergey Kykhov on 19.08.2023.
//

import Foundation

// MARK: - CharactersModelElement
struct CharactersModelElement: Decodable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Decodable {
    let name: String
    let url: String
}

// MARK: - Episodes
struct ModelEpisodesRepresentable: Decodable {
    let air_date: String
    let id: Int
    let name: String
    let episode: String
}

// MARK: - LocationsRepresentable
struct ModelLocationsRepresentable: Decodable {
    let name: String
    let type: String
}
