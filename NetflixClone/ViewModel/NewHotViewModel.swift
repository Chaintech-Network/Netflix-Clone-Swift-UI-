//
//  NewHotViewModel.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 10/02/24.
//

import Foundation


final class NewHotViewModel: ObservableObject {
    
    @Published var imageAnimation   : Bool = false
    @Published var newHotModel      : [MovieDetailModel] = []
    @Published var homeSection      : [HomeSection] = []
    @Published var activeTag        : String = "Upcoming Movies"
    @Published var isloading        : Bool = false
    
    private var serviceManger       : HomeManagerDelegate
    init(serviceManger: HomeManagerDelegate = HomeManager()) {
        self.serviceManger = serviceManger
        Task{
            try await manageHomeResponse()
        }
    }
    
}

// MARK: - Funcationality and Business Logic
extension NewHotViewModel {
}

// MARK: - API Response Handler
extension NewHotViewModel {
    
    @MainActor
    func manageHomeResponse() async throws {
        isloading = true
        let popularResult = try await fetchPopular()
        let trendingMovieResult = try await fetchTrendingMovies()
        let trendingTvResult = try await fetchTrendingTv()
        let upComingResult = try await fetchUpComing()
        let topRatedResult = try await fetchTopRated()
        homeSection.append(.upComing(model: upComingResult))
        homeSection.append(.popular(model: popularResult))
        homeSection.append(.trendingTv(model: trendingTvResult))
        homeSection.append(.topRate(model: topRatedResult))
        homeSection.append(.trendingMovies(model: trendingMovieResult))
        fetchUserRecomendation(list: homeSection[0])
        isloading = false
    }
    
    @MainActor
    func fetchPopular()  async throws -> [MovieDetailModel] {
        guard let popularUrl = URL(string: Constant.discoverUrl) else {return []}
        let popularResult = try await serviceManger.getTrendingMovies(url: popularUrl)
        return popularResult
    }
    
    @MainActor
    func fetchTrendingMovies()  async throws -> [MovieDetailModel]{
        guard let trendingUrl = URL(string: Constant.trandingMovie) else {return []}
        let trendingResult = try await serviceManger.getTrendingMovies(url: trendingUrl)
        return trendingResult
    }
    
    @MainActor
    func fetchTrendingTv()  async throws -> [MovieDetailModel]{
        guard let trendingUrl = URL(string: Constant.trendingTv) else {return []}
        let trendingResult = try await serviceManger.getTrendingMovies(url: trendingUrl)
        return trendingResult
    }
    
    @MainActor
    func fetchUpComing()  async throws -> [MovieDetailModel]{
        guard let trendingUrl = URL(string: Constant.getUpComing) else {return []}
        let trendingResult = try await serviceManger.getTrendingMovies(url: trendingUrl)
        return trendingResult
    }
    
    @MainActor
    func fetchTopRated()  async throws -> [MovieDetailModel]{
        guard let trendingUrl = URL(string: Constant.getTopRated) else {return []}
        let trendingResult = try await serviceManger.getTrendingMovies(url: trendingUrl)
        return trendingResult
    }
    
    public func fetchUserRecomendation(list: HomeSection) {
        newHotModel.removeAll()
        switch list {
        case .upComing(model: let model): self.newHotModel = model
        case .popular(model: let model): self.newHotModel = model
        case .trendingTv(model: let model): self.newHotModel = model
        case .topRate(model: let model): self.newHotModel = model
        case .trendingMovies(model: let model): self.newHotModel = model
        }
    }
    
    public func handlerDate(dateString: String, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = dateFormatter.date(from: dateString) {
            // Create a DateFormatter for the desired format
            let desiredDateFormatter = DateFormatter()
            desiredDateFormatter.dateFormat = format
            // Format the parsed date with the desired format
            let formattedDateString = desiredDateFormatter.string(from: originalDate)
            return formattedDateString
        } else {
            return ""
        }
    }

}

