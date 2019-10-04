//
//  StarshipController.swift
//  starwarsAPI
//
//  Created by Matthew O'Connor on 10/3/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation

class StarshipController {
    let baseURL = URL(string: StarshipConstants.baseURL)
    
    func fetchStarships(with searchText: String, completion: @escaping ([Starship?]) -> Void) {
        guard let url = baseURL else {completion([]); return}
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let queryItem = URLQueryItem(name: StarshipConstants.keyItem, value: searchText)
        
        urlComponents?.queryItems = [queryItem]
        
        guard let finalURL = urlComponents?.url else {completion([]);return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([]); return
            }
            guard let data = data else {completion([]);return}
            do {
                let decoded = try JSONDecoder().decode(TopLevelDict.self, from: data)
                completion(decoded.starships)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        .resume()
    }
    
    func getFilms(filmURL: String, completion: @escaping (Films?) -> Void) {
        guard let url = URL(string: filmURL) else {completion(nil); return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            guard let data = data else {completion(nil);return}
            do {
                let film = try JSONDecoder().decode(Films.self, from: data)
                completion(film)
            } catch {
                completion(nil)
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        .resume()
    }
}
