//
//  ModelGit.swift
//  SWG
//
//  Created by Максим Сулим on 28.06.2023.
//

import Foundation

// MARK: - Welcome
struct ResultsGit: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [ResultsDataGit]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Item
struct ResultsDataGit: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String?
    let gravatarID: String
    let url, htmlURL, followersURL, subscriptionsURL: String
    let organizationsURL, reposURL, receivedEventsURL: String
    let type: String
    let score: Int
    let followingURL, gistsURL, starredURL, eventsURL: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case receivedEventsURL = "received_events_url"
        case type, score
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case eventsURL = "events_url"
        case siteAdmin = "site_admin"
    }
}
