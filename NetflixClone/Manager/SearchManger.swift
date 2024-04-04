//
//  SearchManger.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 31/12/23.
//

import Foundation
import Combine


protocol SearchMangerDelegate {
    func getDisCover(url: URL) async throws -> [MovieDetailModel]
    func getSearch(url: URL) async throws -> [MovieDetailModel]
}

final class SearchManger: SearchMangerDelegate  {
    
    private var serviceManager : SearchServiceDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init(serviceManager: SearchServiceDelegate = SearchService()) {
        self.serviceManager = serviceManager
    }
    
    func getDisCover(url: URL) async throws -> [MovieDetailModel] {
        return await withCheckedContinuation { continuation in
            serviceManager.apiDiscover(with: url)
                .receive(on: DispatchQueue.main)
                .sink { result in
                    switch result{
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        continuation.resume(returning: [])
                    }
                } receiveValue: { resp in
                    continuation.resume(returning: resp.results)
                }.store(in: &cancellables)

        }
    }
    
    func getSearch(url: URL) async throws -> [MovieDetailModel] {
        return await withCheckedContinuation { continuation in
            serviceManager.apiSearch(with: url)
                .receive(on: DispatchQueue.main)
                .sink { result in
                    switch result{
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        continuation.resume(returning: [])
                    }
                } receiveValue: { resp in
                    continuation.resume(returning: resp.results)
                }.store(in: &cancellables)

        }
    }

    
}
