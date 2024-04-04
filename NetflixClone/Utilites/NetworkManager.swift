//
//  NetworkManager.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 25/12/23.
//

import Foundation
import UIKit


enum APIError: Error {
    case BadUrl
    case NoData
    case DecodingError
}


protocol APIHandlerDelegate {
    func fetchData(url: URL, completion: @escaping(Result<Data,APIError>) -> Void)
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T,APIError>) -> Void)
}

final class NetworkManager {
    let apiHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(apiHandler: APIHandlerDelegate = APIHandler(), responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T:Codable>(type: T.Type, url: URL, completion: @escaping(Result<T,APIError>) -> Void) {
        apiHandler.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { response in
                    switch response {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

final class APIHandler: APIHandlerDelegate {
    func fetchData(url: URL, completion: @escaping (Result<Data, APIError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.NoData))
                return
            }
            let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            debugPrint("URL------",url)
            debugPrint(result as Any)
            completion(.success(data))
        }.resume()
    }
}

final class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T>(type: T.Type, data: Data, completion: (Result<T, APIError>) -> Void) where T : Decodable, T : Encodable {
        let response = try? JSONDecoder().decode(type.self, from: data)
        if let responses = response {
            return completion(.success(responses))
        }else{
            return completion(.failure(.DecodingError))
        }
    }
}
