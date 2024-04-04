//
//  GamesContentView.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 13/01/24.
//

import SwiftUI

struct GamesContentView: View {
    
    @StateObject private var viewModel: GamesViewModel
    
    init(viewModel: GamesViewModel = GamesViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 10){
                    let random = viewModel.randomGame.randomElement()
                    NavigationLink {
                        GamesDetailContentView(gameModel: random ?? viewModel.defaulValue)
                    } label: {
                        Image(random?.image ?? "moneyMovers")
                            .resizable()
                            .scaledToFill()
                            .frame(width: rect().width,height: rect().height/2)
                            .clipped()
                            .overlay {
                                ZStack{
                                    LinearGradient(colors: [.black.opacity(0.1),.clear,.black.opacity(0.1),.black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                                }
                            }
                            .padding(.vertical,15)
                    }
                    listView()
                }
            }
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    HStack{
                        Button(action: {}, label: {
                            Text("Games")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        })
                        Spacer()
                    }
                }
            }
        }
    }
    
    
    @ViewBuilder
    func listView() -> some View {
        ForEach(viewModel.gamesSection) { section in
            VStack(spacing:15){
                HStack{
                    Text(section.id.capitalizesFirst())
                        .foregroundStyle(Color.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding(.horizontal,15)
                ScrollView(.horizontal) {
                    HStack(spacing: 12){
                        switch section {
                        case .Winter(let model):
                            navigateToGame(model: model)
                        case .exclusive( let model):
                            navigateToGame(model: model)
                        case .nano(let model):
                            navigateToGame(model: model)
                        case .brain(let model):
                            navigateToGame(model: model)
                        case .hotGames(let model):
                            navigateToGame(model: model)
                        }
                    }
                    .padding(.horizontal,15)
                }
                .scrollIndicators(.hidden)
            }
        }

    }
    
    @ViewBuilder
    func imageView(list: GamesModel) -> some View {
        VStack(spacing: 8) {
            Image(list.image)
                .resizable()
                .scaledToFill()
                .frame(width: rect().width/2.5, height: rect().width/2.5)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    @ViewBuilder
    private func navigateToGame(model: [GamesModel]) -> some View {
        ForEach(model, id: \.self) { model in
            NavigationLink {
                GamesDetailContentView(gameModel: model)
            } label: {
                imageView(list: model)
            }
        }
    }
    
}



#Preview {
    GamesContentView()
}
