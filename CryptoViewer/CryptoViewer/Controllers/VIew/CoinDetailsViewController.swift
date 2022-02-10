//
//  CoinDetailsViewController.swift
//  CryptoViewer
//
//  Created by Arian Mohajer on 2/9/22.
//

import UIKit

class CoinDetailsViewController: UIViewController {

    var conversion: Conversion? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    var ticker: String? {
        didSet {
            DispatchQueue.main.async {
                self.tickerLabel.text = self.ticker
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var tickerLabel: UILabel!
    
    @IBOutlet weak var namePlaceholderLabel: UILabel!
    @IBOutlet weak var tickerPlaceholderLabel: UILabel!
    @IBOutlet weak var pricePlaceholderLabel: UILabel!
    @IBOutlet weak var volumePlaceholderLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let conversion = conversion else {
            return
        }
        
        nameLabel.text = conversion.markets[0].name
        priceLabel.text = "\(conversion.markets[0].price)"
        
        let roundedVolume = Int(conversion.markets[0].volume.rounded())
        volumeLabel.text = "\(roundedVolume)"
    }
}
