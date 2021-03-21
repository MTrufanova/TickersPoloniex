//
//  TickersPresenter.swift
//  TickersPoloniex
//
//  Created by msc on 16.03.2021.
//
protocol TickersPresentationLogic {
    func presentSuccess(data: [TickersModel])
    func presentFail()
}

class TickersPresenter {
    // MARK: - External var
    weak var viewController: TickersDisplayLogic?
    
}

//MARK: - Presentation logic
extension TickersPresenter: TickersPresentationLogic {
    
    func presentSuccess(data: [TickersModel]) {
        let viewModel = data.map { model -> TickerViewModel in
            let cellModel = TickerViewModel(
                pair: model.namePair.split(separator: "_").joined(separator: "/"),
                lastPrice: model.tickerInfo.last,
                highestBid: model.tickerInfo.highestBid,
                percent: Float(model.tickerInfo.percentChange) ?? 0)
            return cellModel
        }
        viewController?.display(data: viewModel)
        
    }
    
    func presentFail() {
        viewController?.showError()
    }
  
}
