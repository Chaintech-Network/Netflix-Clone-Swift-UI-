//
//  Constant.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 26/12/23.
//

import Foundation

struct Constant {
    static let Api_Key                    = "da30c439534ec12d2d71ce5f96545866"
    static let baseURl                    = "https://api.themoviedb.org/3/"
    static let imageURL                   = "https://image.tmdb.org/t/p/w500/"
    static let popularUrl                 = baseURl+"/movie/popular?api_key="+Api_Key
    static let trandingMovie              = baseURl+"trending/movie/day?api_key="+Api_Key
    static let trendingTv                 = baseURl+"/trending/tv/day?api_key="+Api_Key
    static let getUpComing                = baseURl+"/movie/upcoming?api_key="+Api_Key
    static let getTopRated                = baseURl+"/movie/top_rated?api_key="+Api_Key
    static let discoverUrl                = baseURl+"/discover/movie?api_key="+Api_Key+"&language=pa&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    static let searchUrl                  = baseURl+"search/movie?api_key="+Api_Key
    static let youtube_Api_key            = "AIzaSyDdt_ZVvDtvLBlgITS9ol-b3M69zIiclqE"
    static let youtube_BaseUrl            = "https://youtube.googleapis.com/youtube/v3/search?"
}
