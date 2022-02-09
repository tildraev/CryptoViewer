//
//  CoinListViewController.swift
//  CryptoViewer
//
//  Created by Arian Mohajer on 2/9/22.
//

import UIKit

class CoinListViewController: UIViewController {

    var topLevelDictionary: TopLevelDictionary? {
        didSet {
            DispatchQueue.main.async {
                self.coinListTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var coinListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        NetworkController.fetchCoinList { result in
            switch result {
                
            case .success(let tld):
                self.topLevelDictionary = tld
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCoinDetails" {
            if let index = coinListTableView.indexPathForSelectedRow {
                if let destination = segue.destination as? CoinDetailsViewController {
                    
                    guard let label = topLevelDictionary?.coins[index.row].label else { return }
                    
                    var ticker = ""
                    
                    for labelChar in label {
                        if labelChar == "/" {
                            break
                        }
                        ticker.append(labelChar)
                    }
                    
                    NetworkController.fetchConversion(firstCurrencyTicker: ticker.lowercased(), secondCurrencyTicker: "btc") { result in
                        switch result {
                        case .success(let conversion):
                            destination.ticker = ticker
                            destination.conversion = conversion
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let topLevelDictionary = topLevelDictionary else { return 0 }
        return topLevelDictionary.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath) as? CoinTableViewCell else { return UITableViewCell() }
        
        guard let topLevelDictionary = topLevelDictionary else { return cell }
        
        cell.coin = topLevelDictionary.coins[indexPath.row]
        cell.updateViews()
        cell.selectionStyle = .none
        
        return cell
    }
}
