//
//  ResultError.swift
//  CryptoViewer
//
//  Created by Arian Mohajer on 2/9/22.
//

import Foundation

enum ResultError: LocalizedError {
    
    //This one takes in a url string so that we can use that in the error message
    case invalidURL(String)
    
    //Datatask and JSON can throw errors
    case thrownError(Error)
    
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
            
        case .invalidURL:
            return "Unable to reach the server. Please try again."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .noData:
            return "The server responded with no data. Please try again."
        case .unableToDecode:
            return "The server responded with bad data. Please try again."
        }
    }
}
