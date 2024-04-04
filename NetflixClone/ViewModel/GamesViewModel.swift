//
//  GamesViewModel.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 28/01/24.
//

import Foundation
import Combine

final class GamesViewModel: ObservableObject {
    
    @Published var gamesSection: [GamesSectionModel] = []
    @Published var randomGame: [GamesModel] = []
    
    private var service: GamesManagerDelegate
    
    init(service: GamesManagerDelegate = GamesManager()) {
        self.service = service
        Task(priority: .utility) {
            try await getGamesList()
        }
    }
    
    var defaulValue: GamesModel {
        return GamesModel(name: "CHRISTMAS MAZE MANIA", descrip: "Begin a festive journey in our Christmas maze game! Guide Santa using your mouse, touch, or keyboard through captivating mazes to bring joy to waiting children. Find optimal paths, deliver heartwarming gifts, and immerse yourself in holiday spirit across 15 challenging levels. Spread Christmas cheer in this enchanting game!", image: "christmasMaze", url: "https://html5.gamedistribution.com/fd8440d9ed374f06b745cb299cb61819/?gd_sdk_referrer_url=https://gamedistribution.com/games/christmas-maze-mania")
    }
    
}

// MARK: - API Response Handler
extension GamesViewModel {
    
    @MainActor
    func getGamesList() async throws {
        let winter = try await service.getWinterSelection()
        let exclusive = try await service.getExclusiveGames()
        let nano = try await service.getNonoGames()
        let brain = try await service.getBrainTeaser()
        let hotGames = try await service.getHotGames()
        let random = [winter,exclusive,nano,brain,hotGames]
        randomGame = random.randomElement() ?? []
        gamesSection.append(.Winter(model: winter))
        gamesSection.append(.exclusive(model: exclusive))
        gamesSection.append(.nano(model: nano))
        gamesSection.append(.brain(model: brain))
        gamesSection.append(.hotGames(model: hotGames))
    }
    
}
