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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func switchButtonTapped(_ sender: Any) {
        
        let tempLeft = leftCurrencyLabel.text
        let tempRight = rightCurrencyLabel.text
        
        leftCurrencyLabel.text = tempRight
        rightCurrencyLabel.text = tempLeft
        
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        if let leftCurrencyLabelText = leftCurrencyLabel.text, !leftCurrencyLabelText.isEmpty,
           let rightCurrencyLabelText = rightCurrencyLabel.text, !rightCurrencyLabelText.isEmpty {
            
            //Do a network call
            
        } else {
        
            //present alert controller
            let alertController = UIAlertController(title: "Required Fields Empty", message: "Please fill out all required fields", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(confirmAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}
