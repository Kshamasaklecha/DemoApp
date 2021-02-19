//
//  NetworkService.swift
//  CollectionDemo
//
//  Created by Kshama Saklecha on 18/02/21.
//

import Foundation
class NetworkService : NSObject {
    public static let shared = NetworkService()
    override init() {}
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    var data: [ResponseData] = [ResponseData]()
    var delegate: CollectionViewProtocol?
    
    func apiCall() {
        dataTask?.cancel()
        let url = URL(string:  "https://jsonplaceholder.typicode.com/posts")
        dataTask =
            defaultSession.dataTask(with: url!) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                guard let data = data, error == nil else {
                    print("error=\(String(describing: error))")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode([ResponseData].self, from:data)
                    self?.delegate?.didReceiveData(result: model)
                    print("responseString = \(String(describing: model))")
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
        dataTask?.resume()
    }
}

protocol CollectionViewProtocol {
    func didReceiveData(result: [ResponseData]?)
}
