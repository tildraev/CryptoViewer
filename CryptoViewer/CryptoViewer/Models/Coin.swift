//
//  Coin.swift
//  CryptoViewer
//
//  Created by Arian Mohajer on 2/9/22.
//

import Foundation

struct TopLevelDictionary: Decodable{
    
    private enum CodingKeys: String, CodingKey {
        case coins = "Markets"
    }
    
    var coins: [Coin]
}

struct Coin: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case label = "Label"
        case name = "Name"
        case priceUSD = "Price_usd"
    }
    
    var label: String
    var name: String
    var priceUSD: Double
}

struct Conversion: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case markets = "Markets"
    }
    
    var markets: [ConversionDetails]
}

struct ConversionDetails: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case label = "Label"
        case name = "Name"
        case price = "Price"
        case volume = "Volume_24h"
    }
    
    var label: String
    var name: String
    var price: Double
    var volume: Double
}
