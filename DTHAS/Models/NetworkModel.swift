//
//  NetworkModel.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

import Foundation

class NetworkModel {
    
    // MARK:- variables
    var gifs: [GIF] = [GIF]()
    
    weak var delegate: NetworkModelDelegate?
    
    private var offset = 0
    
    
    // MARK:- functions
    func loadMore(search: String) {
        let urlString = search.isEmpty ? (Constants.trendingURL + "&offset=\(offset)") : (Constants.searchURL + "&offset=\(offset)&q=\(search.urlEncoded!)")
        
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
            if let err = error {
                self.delegate?.error(message: err.localizedDescription)
                return
            }
            
            self.offset += 16
            
            guard let responseData = data else { return }
            do {
                let giphyArray = try JSONDecoder().decode(GiphyArray.self, from: responseData)
                self.gifs = self.gifs + giphyArray.gifs
                self.delegate?.reloadTable()
            } catch {
                self.delegate?.error(message: error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func refresh(search: String) {
        gifs.removeAll()
        offset = 0
        loadMore(search: search)
    }
    
    func fetchGIF(_ id: String, completion: @escaping (_ gif: GIF?, _ error: Error?) -> Void) {
        let urlString = Constants.baseURL + id + "?api_key=\(Constants.apiKey)"
        
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
            if let err = error {
                completion(nil, err)
                return
            }
            
            guard let responseData = data else { return }
            do {
                let giphy = try JSONDecoder().decode(Giphy.self, from: responseData)
                completion(giphy.gif, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
