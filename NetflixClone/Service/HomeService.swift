//
//  HomeServiceManager.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 26/12/23.
//

import Foundation
import Combine


protocol HomeServiceDelegate {
    func apiTrendingMovie(with url: URL) -> Future<MovieTitleResponse,Error>
    func apiTrendingTv(with url: URL) -> Future<MovieTitleResponse,Error>
    func apiPopular(with url: URL) -> Future<MovieTitleResponse,Error>
    func apiUpComing(with url: URL) -> Future<MovieTitleResponse,Error>
    func apiTopRated(with url: URL) -> Future<MovieTitleResponse,Error>
    func apiYoutubeUrl(url: URL) -> Future<YoutubeResponse, Error>
}

final class HomeService : HomeServiceDelegate {

    func apiTrendingMovie(with url: URL) -> Future<MovieTitleResponse, Error> {
        let router = ServiceManager<MovieTitleResponse>()
        return router.handlerRequestPublisher(url: url)
    }

    func apiTrendingTv(with url: URL) -> Future<MovieTitleResponse, Error> {
        let router = ServiceManager<MovieTitleResponse>()
        return router.handlerRequestPublisher(url: url)
    }
    
    func apiPopular(with url: URL) -> Future<MovieTitleResponse, Error> {
        let router = ServiceManager<MovieTitleResponse>()
        return router.handlerRequestPublisher(url: url)
    }
    
    func apiUpComing(with url: URL) -> Future<MovieTitleResponse, Error> {
        let router = ServiceManager<MovieTitleResponse>()
        return router.handlerRequestPublisher(url: url)
    }
    
    func apiTopRated(with url: URL) -> Future<MovieTitleResponse, Error> {
        let router = ServiceManager<MovieTitleResponse>()
        return router.handlerRequestPublisher(url: url)
    }
    
    func apiYoutubeUrl(url: URL) -> Future<YoutubeResponse, any Error> {
        let router = ServiceManager<YoutubeResponse>()
        return router.handlerRequestPublisher(url: url)
    }
    
}
