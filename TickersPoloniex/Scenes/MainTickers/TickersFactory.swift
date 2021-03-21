//
//  TickersFactory.swift
//  TickersPoloniex
//
//  Created by msc on 21.03.2021.
//

import Foundation


class TickersFactory {
    static func getScreen() -> TickersTableViewController {
        let viewController = TickersTableViewController()
        let presenter = TickersPresenter()
        let api = APIClientclass()
        let interactor = TickersInteractor(presenter: presenter , api: api )
        
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        return viewController
    }
}
