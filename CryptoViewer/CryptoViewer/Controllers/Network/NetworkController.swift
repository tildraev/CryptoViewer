//
//  NetworkController.swift
//  CryptoViewer
//
//  Created by Arian Mohajer on 2/9/22.
//

import Foundation

class NetworkController {
    private static let baseURLString = "https://www.worldcoinindex.com"
    
    static func fetchCoinList(completion: @escaping (Result<TopLevelDictionary, ResultError>) -> Void ) {
        guard let baseURL = URL(string: baseURLString) else {
            completion(.failure(.invalidURL(baseURLString)))
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/apiservice/json"
        let apiKeyQuery = URLQueryItem(name: "key", value: "AsEnCev6qZIYi80m4zcJ1ML3XriV8Vvu4Bx")
        urlComponents?.queryItems = [apiKeyQuery]
        
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.invalidURL(urlComponents?.url?.absoluteString ?? "" )))
            return
        }
        
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(topLevelDictionary))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchConversion(firstCurrencyTicker: String, secondCurrencyTicker: String, completion: @escaping (Result<Conversion, ResultError>) -> Void) {
        let baseURLString = "https://www.worldcoinindex.com"
        let apiKey = "AsEnCev6qZIYi80m4zcJ1ML3XriV8Vvu4Bx"
        guard let  baseURL = URL(string: baseURLString) else {
            completion(.failure(.invalidURL(baseURLString)))
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/apiservice/ticker"
        let keyQuery = URLQueryItem(name: "key", value: apiKey)
        let labelQuery = URLQueryItem(name: "label", value: "\(firstCurrencyTicker)\(secondCurrencyTicker)")
        let fiatQuery = URLQueryItem(name: "fiat", value: "USD")
        urlComponents?.queryItems = [keyQuery, labelQuery, fiatQuery]
        
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.invalidURL(urlComponents?.url?.absoluteString ?? "" )))
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedConversion = try JSONDecoder().decode(Conversion.self, from: data)
                
                completion(.success(decodedConversion))
            } catch {
                completion(.failure(.thrownError(error)))
                return
            }

        }.resume()
    }
}
