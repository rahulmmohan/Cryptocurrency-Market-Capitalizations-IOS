//
//  ViewController.swift
//  NetworkingSample
//
//  Created by Rahul Mohan on 01/03/18.
//  Copyright © 2018 Rahul Mohan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var netwokingHelper = NetworkingHelper()
    var currencies : [CryptoCurrency]?
    let tableViewCellIdentifier = "CurrencyCell"
    weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        self.tableView.backgroundView = activityIndicatorView
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.activityIndicatorView = activityIndicatorView
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.startAnimating()
        self.netwokingHelper.getCryptocurrency(){(cions,error)->() in
            self.currencies = cions
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = currencies{
            return currencies!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tap")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! cryptoCurrencyCell
        guard let _ = currencies else {
            return tableViewCell
        }
        let currency = currencies![indexPath.row]
        
        tableViewCell.currencyName?.text = currency.name!+"("+currency.symbol!+")"
        tableViewCell.price?.text = currency.price_usd!+" USD"  //String.init(describing: currency.price_usd)""
        tableViewCell.percentChange?.text = "("+currency.percent_change_24h!+"%)"
        let percent_change_24h = Float(currency.percent_change_24h!)
        if(percent_change_24h! < 0){
            tableViewCell.percentChange.textColor = UIColor.red
        }else{
            tableViewCell.percentChange.textColor = UIColor.green   
        }
        tableViewCell.rank?.text = currency.rank!
        tableViewCell.marketCapital?.text = currency.market_cap_usd!
        tableViewCell.volume24?.text = currency.h_volume_usd!
        tableViewCell.currencyImage.loadImageFromUrl(urlString: "https://files.coinmarketcap.com/static/widget/coins_legacy/64x64/"+currency.name!.lowercased().replacingOccurrences(of: " ", with: "-")+".png")
        return tableViewCell
    }
    
    
}
extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
class cryptoCurrencyCell:UITableViewCell{
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var percentChange: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var marketCapital: UILabel!
    @IBOutlet weak var volume24: UILabel!
    
}



