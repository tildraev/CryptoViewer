//
//  Coin.swift
//  CryptoViewer
//
//  Created by Arian Mohajer on 2/9/22.
//

import Foundation

class TopLevelDictionary {
    
    var tickerList: [String:Any]
    
    init? (dictionary: [String:Any]) {
        var tempCoinDictionary: [String:Any] = [:]
        
        for coin in dictionary {
            tempCoinDictionary[coin.key] = coin.value
        }
        
        self.tickerList = tempCoinDictionary
    }
}

struct Coin: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
    
    var fullName: String
}

struct DecodedTopLevelDictionary: Decodable {
    
}
