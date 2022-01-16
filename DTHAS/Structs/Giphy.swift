//
//  Giphy.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

struct Giphy: Codable {
    
    // MARK:- variables
    let gif: GIF
    
    enum CodingKeys: String, CodingKey {
        case gif = "data"
    }
}
