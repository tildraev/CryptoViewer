//
//  NetworkController.swift
//  CryptoViewer
//
//  Created by Arian Mohajer on 2/9/22.
//

import Foundation

class NetworkController {
    private static let baseURLString = "https://api.exchange.cryptomkt.com"
    
    static func fetchCoinList(completion: @escaping (Result<TopLevelDictionary, ResultError>) -> Void ) {
        guard let baseURL = URL(string: baseURLString) else {
            completion(.failure(.invalidURL(baseURLString)))
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        urlComponents?.path = "/api/3/public/currency"
        
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.invalidURL(urlComponents?.url?.debugDescription ?? "")))
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
                guard var decodedData = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String:Any] else {
                    completion(.failure(.unableToDecode))
                    return
                }
                
                //                var coinDetails: [[String:String]] = [[:]]
                //
                //                for dictionary in decodedData {
                //                    let decodedName = try JSONDecoder().decode(CoinDetails.self, from: Data(decodedData.values))
                //                    coinDetails.append([dictionary.key : dictionary.value])
                //                }
                //
                guard let topLevelDictionary = TopLevelDictionary(dictionary: decodedData) else {
                    completion(.failure(.unableToDecode))
                    return
                }
                completion(.success(topLevelDictionary))
                
            } catch {
                print(finalURL)
                completion(.failure(.thrownError(error)))
                return
            }
        }.resume()
        
        
    }
//    static func fetchCoinName(from tickerList: [String], completion: @escaping (Result<CoinDetails, ResultError>) -> Void ) {
//        for ticker in tickerList {
//            
//        }
//    }
}
