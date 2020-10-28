//
//  coinDataFormatForJSON.swift
//  ByteCoin
//
//  Created by PMJs on 27/3/2563 BE.
//  Copyright © 2563 The App Brewery. All rights reserved.
//

import Foundation

struct coinDataFormatForJSON :Decodable {
    let time : String
    let asset_id_base : String
    let asset_id_quote : String
    let rate : Double
    
}
