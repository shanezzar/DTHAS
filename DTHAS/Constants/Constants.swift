//
//  Constants.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

struct Constants {
    
    // MARK:- variables
    static let apiKey = "cpSgAEtqiGajP3ZC5pe1Pl9JJMCuWi8m"
    static let baseURL = "https://api.giphy.com/v1/gifs/"
    
    static var trendingURL: String {
        baseURL + "trending?rating=pg&limit=16&api_key=" + apiKey
    }
    
    static var searchURL: String {
        baseURL + "search?limit=16&api_key=" + apiKey
    }
    
}
