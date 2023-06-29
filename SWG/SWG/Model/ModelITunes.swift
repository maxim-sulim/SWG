//
//  ModelITunes.swift
//  SWG
//
//  Created by Максим Сулим on 27.06.2023.
//

import Foundation

import Foundation

// MARK: - Results
struct ResultsITunes: Codable {
    var results: [ResultsDataITunes]
}

// MARK: - Result
struct ResultsDataITunes: Codable {
    let artistID, collectionID: Int?
    let artistName: String
    let collectionName, collectionCensoredName: String?
    let artistViewURL, collectionViewURL: String?
    let artworkUrl60, artworkUrl100: String?
    let trackName, trackCensoredName: String?
    
}
