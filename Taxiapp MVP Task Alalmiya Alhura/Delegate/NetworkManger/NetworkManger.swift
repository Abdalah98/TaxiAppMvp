//
//  NetworkManger.swift
//  Taxiapp MVP Task Alalmiya Alhura
//
//  Created by Abdallah on 2/17/22.
//

import Foundation

class NetworkManger {
    
    static let shared = NetworkManger()
    

func searchCountryWeather(searchText:String,completion: @escaping (Result<Weather , ResoneError>) -> Void){
    let urlString = URLS.weatherMapUrl +  "data/2.5/weather?q=\(searchText)&appid=" + ApiKey.apiKey
    fetchGenericJSONData(urlString: urlString, completion: completion)
}



func fetchGenericJSONData<T:Codable>(urlString:String,completion: @escaping (Result<T , ResoneError>) -> Void){
    guard let url = URL(string: urlString) else {
        completion(.failure(.invaldURL))
        return }
    URLSession.shared.dataTask(with: url) { (data, response, err) in
        if let _ = err {
            completion(.failure(.unableToComplete))
            return
        }
        
        guard let response  = response as? HTTPURLResponse ,response.statusCode == 200 else {
            completion(.failure(.invalidResponse))
            
            return
        }
        guard let data = data else {
            completion(.failure(.invalidData))
            return }
        do {
            let objects = try JSONDecoder().decode(T.self, from: data)
            // success
            completion(.success(objects))
        } catch {
            completion(.failure(.invalidData))
        }
    }.resume()
}}
