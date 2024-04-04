//
//  HomeManager.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 27/12/23.
//

import Foundation
import Combine

protocol HomeManagerDelegate {
    func getPopularMovies(url: URL) async throws -> [MovieDetailModel]
    func getTrendingMovies(url: URL) async throws -> [MovieDetailModel]
    func getTrendingTV(url: URL) async throws -> [MovieDetailModel]
    func getUpComing(url: URL) async throws -> [MovieDetailModel]
    func getTopRated(url: URL) async throws -> [MovieDetailModel]
    func fetchYoutubeUrl(url: URL) async throws -> Item?
}

final class HomeManager : HomeManagerDelegate {

    private var serviceManager : HomeServiceDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init(serviceManager: HomeServiceDelegate = HomeService()) {
        self.serviceManager = serviceManager
    }
    
}

extension HomeManager {
    func getPopularMovies(url: URL) async throws -> [MovieDetailModel] {
        return await withCheckedContinuation { continuation in
            serviceManager.apiPopular(with: url)
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
    
    func getTrendingMovies(url: URL) async throws -> [MovieDetailModel] {
        return await withCheckedContinuation { continuation in
            serviceManager.apiTrendingMovie(with: url)
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
    
    func getTrendingTV(url: URL) async throws -> [MovieDetailModel] {
        return await withCheckedContinuation { continuation in
            serviceManager.apiTrendingMovie(with: url)
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
    
    func getUpComing(url: URL) async throws -> [MovieDetailModel] {
        return await withCheckedContinuation { continuation in
            serviceManager.apiTrendingMovie(with: url)
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
    
    func getTopRated(url: URL) async throws -> [MovieDetailModel] {
        return await withCheckedContinuation { continuation in
            serviceManager.apiTrendingMovie(with: url)
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
    
    func fetchYoutubeUrl(url: URL) async throws -> Item? {
        return await withCheckedContinuation { continuation in
            serviceManager.apiYoutubeUrl(url: url)
                .receive(on: DispatchQueue.main)
                .sink { result in
                    switch result{
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                        continuation.resume(returning: nil)
                    }
                } receiveValue: { resp in
                    continuation.resume(returning: resp.items[0])
                }.store(in: &cancellables)

        }
    }
}
