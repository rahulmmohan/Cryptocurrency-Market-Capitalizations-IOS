//
//  NetworkingHelper.swift
//  NetworkingSample
//
//  Created by Rahul Mohan on 01/03/18.
//  Copyright © 2018 Rahul Mohan. All rights reserved.
//

import Foundation

class NetworkingHelper {
    let url = URL(string:"https://api.coinmarketcap.com/v1/ticker/?limit=20")
    let translatorHelper = TranslatorHelper()
    
    func getCryptocurrency(callback:@escaping ([CryptoCurrency]?,Error?)->()) {
       let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            var currencies = [CryptoCurrency]()
            if let unwrappedData = data {
                currencies = self.translatorHelper.translateCurrenciesFromJSON(data: unwrappedData)!
            }
            callback(currencies,error)
        }
        task.resume()
    }
}
