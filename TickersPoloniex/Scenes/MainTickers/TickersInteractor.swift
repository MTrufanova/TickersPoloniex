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
    
    //MARK: - External var
    var presenter: TickersPresentationLogic?
   
    
    
}

//MARK: - Business logic
extension TickersInteractor: TickersBusinessLogic {
    
   
    @objc func fetchTickers() {
       
        let api = APIClientclass()
        var tickers = [TickersModel]()
        
        api.fetchData(onResult: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ticker):
                    
                    for (_, _) in ticker {
                        tickers = ticker.map(TickersModel.init).sorted(by: {$0.namePair < $1.namePair})
                        self.presenter?.presentSuccess(data: tickers)
                    }
                    
                case .failure(_):
                   // tickers = []
                    self.presenter?.presentFail()
                    
                }
               
            }
        })
        
    
    }
}
