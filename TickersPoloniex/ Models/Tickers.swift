//
//  Tickers.swift
//  TickersPoloniex
//
//  Created by msc on 08.03.2021.
//

import Foundation


typealias TickersResponse = [String: Tickers]

struct Tickers: Decodable {
    let last: String
    let highestBid: String
    let percentChange: String
}

struct TickersModel {
    let namePair: String
    let tickerInfo: Tickers
}


