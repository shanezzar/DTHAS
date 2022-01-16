//
//  GiphyArray.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

struct GiphyArray: Codable {
    
    // MARK:- variables
    let gifs: [GIF]
    
    enum CodingKeys: String, CodingKey {
        case gifs = "data"
    }
}
