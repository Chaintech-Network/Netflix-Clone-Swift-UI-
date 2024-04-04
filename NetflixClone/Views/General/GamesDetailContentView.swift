//
//  GamesDetailContentView.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 04/02/24.
//

import SwiftUI

struct GamesDetailContentView: View {
    
    @Environment (\.dismiss) private var dismiss
    @State private var isShow: Bool = false
    private var gameModel : GamesModel
    
    init(gameModel: GamesModel) {
        self.gameModel = gameModel
    }
    
    var body: some View {
        NavigationStack{
            ZStack(content: {
                VStack(alignment: .leading, spacing: 15 ,content: {
                    Image(gameModel.image)
                        .resizable()
                        .frame(height: 400)
                        .overlay(alignment: .topLeading) {
                            Button(action: {
                                dismiss()
                            }, label: {
                                HStack{
                                    Image(systemName: "arrowshape.turn.up.backward.fill")
                                        .font(.title)
                                        .foregroundStyle(.white)
                                        .padding(10)
                                        .background(.white.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                .padding(.top,40)
                                .padding(.horizontal,20)
                            })
                        }
    
                    subTitleView
                    ScrollView {
                        navigationButton
                        descriptionView
                            .padding(.bottom,20)
                    }
                })
            })
            .fullScreenCover(isPresented: $isShow, content: {
                if let url = URL(string: gameModel.url) {
                    SafariView(url: url)
                }else{
                    EmptyView()
                }
                
            })
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
        }
    }
    
    private var subTitleView: some View {
        HStack(spacing: 10, content: {
            Image(gameModel.image)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 10 ,content: {
                Text(gameModel.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("Games")
                    .font(.caption2)
                    .fontWeight(.medium)
            })
        })
        .padding(.horizontal,15)
    }
    
    private var navigationButton: some View {
        Button(action: {
            isShow.toggle()
        }, label: {
            HStack(spacing: 10, content: {
                Image(systemName: "play.fill")
                    .foregroundStyle(.white)
                Text("Play")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
            })
            .frame(maxWidth: .infinity)
            .padding(.vertical,15)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal,15)
            .padding(.top,15)
        })
    }
    
    private var descriptionView: some View {
        Text(gameModel.descrip)
            .multilineTextAlignment(.leading)
            .font(.headline)
            .fontWeight(.medium)
            .padding(.horizontal,15)
    }
}

#Preview {
    GamesDetailContentView(gameModel: GamesModel(name: "CHRISTMAS MAZE MANIA", descrip: "Begin a festive journey in our Christmas maze game! Guide Santa using your mouse, touch, or keyboard through captivating mazes to bring joy to waiting children. Find optimal paths, deliver heartwarming gifts, and immerse yourself in holiday spirit across 15 challenging levels. Spread Christmas cheer in this enchanting game!", image: "christmasMaze", url: "https://html5.gamedistribution.com/fd8440d9ed374f06b745cb299cb61819/?gd_sdk_referrer_url=https://gamedistribution.com/games/christmas-maze-mania"))
}
