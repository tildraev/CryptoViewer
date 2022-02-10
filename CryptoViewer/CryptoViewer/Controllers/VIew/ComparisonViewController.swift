//
//  ComparisonViewController.swift
//  CryptoViewer
//
//  Created by Arian Mohajer on 2/9/22.
//

import UIKit

class ComparisonViewController: UIViewController {

    
    @IBOutlet weak var leftCurrencyLabel: UITextField!
    @IBOutlet weak var rightCurrencyLabel: UITextField!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var conversionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        switchButton.layer.cornerRadius = 15
        switchButton.layer.borderWidth = 1
        switchButton.layer.borderColor = CGColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        searchButton.layer.cornerRadius = 15
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = .init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    }
    
    @IBAction func switchButtonTapped(_ sender: Any) {
        
        leftCurrencyLabel.resignFirstResponder()
        rightCurrencyLabel.resignFirstResponder()
        
        let tempLeft = leftCurrencyLabel.text
        let tempRight = rightCurrencyLabel.text
        
        leftCurrencyLabel.text = tempRight
        rightCurrencyLabel.text = tempLeft
        
        
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        leftCurrencyLabel.resignFirstResponder()
        rightCurrencyLabel.resignFirstResponder()
        
        if let leftCurrencyLabelText = leftCurrencyLabel.text, !leftCurrencyLabelText.isEmpty,
           let rightCurrencyLabelText = rightCurrencyLabel.text, !rightCurrencyLabelText.isEmpty {
            
            //Do a network call
            NetworkController.fetchConversion(firstCurrencyTicker: "\(leftCurrencyLabelText)btc-", secondCurrencyTicker: "\(rightCurrencyLabelText)btc") { result in
                switch result {
                    
                case .success(let conversion):
                    DispatchQueue.main.async {
                        
                        if conversion.markets.count != 2 {
                            //present alert controller
                            let alertController = UIAlertController(title: "Invalid ticker entered", message: "Please check ticker before continuing", preferredStyle: .alert)
                            let confirmAction = UIAlertAction(title: "OK", style: .default)
                            alertController.addAction(confirmAction)
                            self.present(alertController, animated: true, completion: nil)
                            return
                        }
                        
                        if conversion.markets[0].label.lowercased().hasPrefix(leftCurrencyLabelText) {
                            let conversionMultiplier = conversion.markets[0].price/conversion.markets[1].price
                            self.conversionLabel.text = "One \(leftCurrencyLabelText) \n is worth \n \(conversionMultiplier) \(rightCurrencyLabelText)"
                        } else {
                            let conversionMultiplier = conversion.markets[1].price/conversion.markets[0].price
                            self.conversionLabel.text = "One \(leftCurrencyLabelText) \n is worth \n \(conversionMultiplier) \(rightCurrencyLabelText)"
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
        } else {
        
            //present alert controller
            let alertController = UIAlertController(title: "Required Fields Empty", message: "Please fill out all required fields", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(confirmAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}
