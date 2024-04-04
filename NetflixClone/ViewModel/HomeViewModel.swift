//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 27/12/23.
//

import Foundation
import Combine

enum TopButtonType : Hashable, Identifiable {
    case play, add
    var id: TopButtonType { self }
}

final class HomeViewModel : ObservableObject {
    
    @Published var imageAnimation   : Bool = false
    @Published var homeSection      : [HomeSection] = []
    @Published var activeTag        : String = "trending Movies"
    @Published var isloading        : Bool = false
    
    
    private var bannerModel         : MovieDetailModel?
    private var serviceManger       : HomeManagerDelegate
    
    init(serviceManger: HomeManagerDelegate = HomeManager()) {
        self.serviceManger = serviceManger
        Task{
            try await manageHomeResponse()
        }
    }
    
}
 // MARK: - Funcationality and Business Logic
extension HomeViewModel {
    var bannerImage : URL? {
        return URL(string: Constant.imageURL+(bannerModel?.poster_path ?? ""))
    }
}

// MARK: - API Response Handler
extension HomeViewModel {
    
    @MainActor
    func manageHomeResponse() async throws {
        isloading = true
        let popularResult = try await fetchPopular()
        let trendingMovieResult = try await fetchTrendingMovies()
        let trendingTvResult = try await fetchTrendingTv()
        let upComingResult = try await fetchUpComing()
        let topRatedResult = try await fetchTopRated()
        guard let banner = popularResult.randomElement() else { return }
        homeSection.append(.trendingMovies(model: trendingMovieResult))
        homeSection.append(.popular(model: popularResult))
        homeSection.append(.trendingTv(model: trendingTvResult))
        homeSection.append(.upComing(model: upComingResult))
        homeSection.append(.topRate(model: topRatedResult))
        bannerModel = banner
        isloading = false
    }
    
    @MainActor
    private func fetchPopular()  async throws -> [MovieDetailModel] {
        guard let popularUrl = URL(string: Constant.discoverUrl) else {return []}
        let popularResult = try await serviceManger.getTrendingMovies(url: popularUrl)
        return popularResult
    }
    
    @MainActor
    private func fetchTrendingMovies()  async throws -> [MovieDetailModel]{
        guard let trendingUrl = URL(string: Constant.trandingMovie) else {return []}
        let trendingResult = try await serviceManger.getTrendingMovies(url: trendingUrl)
        return trendingResult
    }
    
    @MainActor
    private func fetchTrendingTv()  async throws -> [MovieDetailModel]{
        guard let trendingUrl = URL(string: Constant.trendingTv) else {return []}
        let trendingResult = try await serviceManger.getTrendingMovies(url: trendingUrl)
        return trendingResult
    }
    
    @MainActor
    private func fetchUpComing()  async throws -> [MovieDetailModel]{
        guard let trendingUrl = URL(string: Constant.getUpComing) else {return []}
        let trendingResult = try await serviceManger.getTrendingMovies(url: trendingUrl)
        return trendingResult
    }
    
    @MainActor
    private func fetchTopRated()  async throws -> [MovieDetailModel]{
        guard let trendingUrl = URL(string: Constant.getTopRated) else {return []}
        let trendingResult = try await serviceManger.getTrendingMovies(url: trendingUrl)
        return trendingResult
    }
    

}
