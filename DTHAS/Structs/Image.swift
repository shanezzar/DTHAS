//
//  Image.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

struct Image: Codable {
    
    // MARK:- variables
    let downsizedMedium: GIFFormat

    enum CodingKeys: String, CodingKey {
        case downsizedMedium = "fixed_height"
    }
}
