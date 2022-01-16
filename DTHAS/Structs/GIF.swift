//
//  GIF.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

struct GIF: Codable {
    
    // MARK:- variables
    let id: String
    var tld: String
    let title: String
    let username: String
    let rating: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id, title, username, rating
        case tld = "source_tld"
        case image = "images"
    }
    
}
