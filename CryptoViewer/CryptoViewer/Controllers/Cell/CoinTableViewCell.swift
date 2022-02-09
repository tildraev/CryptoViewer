//
//  CoinTableViewCell.swift
//  CryptoViewer
//
//  Created by Arian Mohajer on 2/9/22.
//

import UIKit

class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    
    var coin: Coin?
    
    func updateViews() {
        guard let coin = coin else {
            return
        }

        coinNameLabel.text = coin.name
        if coin.priceUSD > 0.001 {
            let roundedPrice = Double(round(100*coin.priceUSD)/100)
                coinPriceLabel.text = "$\(roundedPrice)"
        } else {
            coinPriceLabel.text = "$\(coin.priceUSD)"
        }
    }
}
