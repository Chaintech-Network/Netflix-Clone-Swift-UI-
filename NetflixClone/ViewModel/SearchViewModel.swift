//
//  SearchViewModel.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 31/12/23.
//

import Foundation
import Combine


final class SearchViewModel : ObservableObject {
    
    @Published var discoverModel            : [MovieDetailModel] = []
    @Published var searchDetail             : [MovieDetailModel] = []
    @Published var searchTxt                : String = ""
    @Published var isLoading                : Bool = false // shimmer effect for suggestion list
    @Published var isSearching              : Bool = false // shimmer effect for during search data
    
    private var serviceManger : SearchMangerDelegate
    
    init(serviceManger: SearchMangerDelegate = SearchManger()) {
        self.serviceManger = serviceManger
        Task{
            try await getDiscover()
        }
    }
    
}

// MARK: - API Response Handler
extension SearchViewModel {
    
    @MainActor
    func getDiscover() async throws {
        isLoading = true
        guard let url = URL(string: Constant.discoverUrl) else {return}
        let result = try await serviceManger.getDisCover(url: url)
        discoverModel = result
        isLoading = false
    }
    
    @MainActor
    func getSearch() async throws {
        isSearching = true
        guard let quary = searchTxt.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: Constant.searchUrl+"&query="+quary) else {return }
        let result = try await serviceManger.getSearch(url: url)
        searchDetail = result
        isSearching = false
    }
}
