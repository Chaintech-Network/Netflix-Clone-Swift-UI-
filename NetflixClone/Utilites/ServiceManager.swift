//
//  ServiceManager.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 27/12/23.
//

import Foundation
import Combine

final class ServiceManager<T: Codable> {
    
    var cancellables = Set<AnyCancellable>()
    
    func handlerRequestPublisher(url: URL) -> Future<T,Error> {
        return Future<T, Error> {  promise in
            NetworkManager().fetchRequest(type: T.self, url: url) {  result in
                switch result {
                case .success(let models):
                    promise(.success(models))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
}
