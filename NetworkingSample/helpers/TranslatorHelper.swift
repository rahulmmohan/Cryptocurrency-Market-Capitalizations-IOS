//
//  TranslatorHelper.swift
//  NetworkingSample
//
//  Created by Rahul Mohan on 02/03/18.
//  Copyright © 2018 Rahul Mohan. All rights reserved.
//

import Foundation

class TranslatorHelper {
    
    func translateCurrenciesFromJSON(data: Data) -> [CryptoCurrency]? {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
            var cryptoCurrencies = [CryptoCurrency]()
            for item in jsonData {
                    let currency = CryptoCurrency()
                    currency.name = item["name"] as? String
                    currency.price_usd = item["price_usd"] as? String
                    currency.symbol = item["symbol"] as? String
                    currency.percent_change_24h = item["percent_change_24h"] as? String
                    currency.rank = item["rank"] as? String
                    currency.market_cap_usd = item["market_cap_usd"] as? String
                    currency.h_volume_usd = item["24h_volume_usd"] as? String
                    cryptoCurrencies.append(currency)
            }
            return cryptoCurrencies
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
}
