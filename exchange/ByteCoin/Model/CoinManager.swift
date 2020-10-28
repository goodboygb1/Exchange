//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdate( coinModel : CoinModel)
    func didFailWithError(error : Error)
}

extension CoinManagerDelegate{
    func didFailWithError(error : Error)  {
        print(error)
    }
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency : String) {
        let urlString = "\(baseURL)/\(currency)?apikey=EFA81A5E2E924AEE8546B55663BBDF81"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handler(data:respone:error:))
            task.resume()
        }
        
    }
    
    func handler(data : Data?, respone:URLResponse?, error : Error?)  {
        if error != nil {
            print(error!)
            return
        } else {
            if let safeData = data {
                if let coin = parseJSON(with: safeData) {
                     delegate?.didUpdate(coinModel: coin)
                }
            }
        }
    }
    
    func parseJSON(with safeData : Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodeAlreadyData = try decoder.decode(coinDataFormatForJSON.self, from: safeData)
            let currencyName = decodeAlreadyData.asset_id_quote
            let rate = decodeAlreadyData.rate
            
            let coinFinalData = CoinModel(rate: rate, currencyName: currencyName)
           return coinFinalData
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
    }
    
}


