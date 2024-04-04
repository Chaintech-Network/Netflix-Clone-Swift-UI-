//
//  SearchService.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 31/12/23.
//

import Foundation
import Combine


protocol SearchServiceDelegate {
    func apiDiscover(with url: URL) -> Future<MovieTitleResponse,Error>
    func apiSearch(with url: URL) -> Future<MovieTitleResponse,Error>
}

final class SearchService: SearchServiceDelegate {

    func apiDiscover(with url: URL) -> Future<MovieTitleResponse, Error> {
        let router = ServiceManager<MovieTitleResponse>()
        return router.handlerRequestPublisher(url: url)
    }
    
    func apiSearch(with url: URL) -> Future<MovieTitleResponse, Error> {
        let router = ServiceManager<MovieTitleResponse>()
        return router.handlerRequestPublisher(url: url)
    }
    
}
