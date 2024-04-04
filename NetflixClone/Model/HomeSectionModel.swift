//
//  HomeSectionModel.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 30/12/23.
//

import Foundation

enum HomeSection: Identifiable {
    case trendingMovies(model: [MovieDetailModel])
    case trendingTv(model: [MovieDetailModel])
    case popular(model: [MovieDetailModel])
    case upComing(model: [MovieDetailModel])
    case topRate(model: [MovieDetailModel])

    var id: String {
        // Return a unique identifier for each case
        switch self {
        case .trendingMovies:
            return "trending Movies"
        case .trendingTv:
            return "trending Tv"
        case .popular:
            return "popular"
        case .upComing:
            return "Upcoming Movies"
        case .topRate:
            return "Top rated"
        }
    }
}

extension HomeSection: Hashable {
    static func == (lhs: HomeSection, rhs: HomeSection) -> Bool {
        // Implement equality check based on your requirements
        switch (lhs, rhs) {
        case (.trendingMovies, .trendingMovies),
             (.trendingTv, .trendingTv),
             (.popular, .popular),
             (.upComing, .upComing),
             (.topRate, .topRate):
            return true
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        // Use the id property for hashing
        hasher.combine(id)
    }
}

