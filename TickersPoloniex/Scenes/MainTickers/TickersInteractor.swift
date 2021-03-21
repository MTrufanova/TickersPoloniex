//
//  TickersInteractor.swift
//  TickersPoloniex
//
//  Created by msc on 16.03.2021.
//

import Foundation

protocol TickersBusinessLogic {
    func fetchTickers()
}


class TickersInteractor {
    
    var presenter: TickersPresentationLogic
    private let api: APIClientclass
    
    init(presenter: TickersPresentationLogic, api: APIClientclass) {
        self.presenter = presenter
        self.api = api
    }
}

//MARK: - Business logic
extension TickersInteractor: TickersBusinessLogic {
    
    func fetchTickers() {
        var tickers = [TickersModel]()
        api.fetchData(onResult: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ticker):
                    for (_, _) in ticker {
                        tickers = ticker.map(TickersModel.init).sorted(by: {$0.namePair < $1.namePair})
                        self.presenter.presentSuccess(data: tickers)
                    }
                case .failure(_):
                    self.presenter.presentFail()
                    
                }
            }
        })
    }
}
