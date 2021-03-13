//
//  APIClient.swift
//  TickersPoloniex
//
//  Created by msc on 08.03.2021.
//

import Foundation

enum APIError: Error {
    case noData
}

protocol APIClient {
    func fetchData(onResult:  @escaping (Result< TickersResponse, Error>) -> Void)
    
}

class APIClientclass: APIClient {
    func fetchData(onResult: @escaping (Result< TickersResponse, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://poloniex.com/public?command=returnTicker") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, respoonse, error in
            
            guard let data = data else {
                onResult(.failure(APIError.noData))
                return
                
            }
            do {
                
                let tickersResponse = try JSONDecoder().decode( TickersResponse.self, from: data)
                onResult(.success(tickersResponse))
                
            } catch (let error){
                print(error)
                onResult(.failure(error))
            }
            
        })
        dataTask.resume()
        
    }
}
