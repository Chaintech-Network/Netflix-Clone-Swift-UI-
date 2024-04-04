//
//  ContentView.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 25/12/23.
//

import SwiftUI
import SDWebImageSwiftUI


struct HomeContentView: View {
    
    @ObservedObject private var viewModel : HomeViewModel
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                GeometryReader {
                    let size = $0.size
                    ScrollView{
                        VStack{
                            headerView()
                                .padding(.horizontal,20)
                                .padding(.vertical,20)
                                .shimmering(active: viewModel.isloading, animation: .bouncy)

                            listView(size: size)
                        }
                        .padding(.bottom,30)
                    }
                    .scrollIndicators(.hidden)

                }
            }
            .ignoresSafeArea(edges: .bottom)
            .onDisappear{UIScrollView.appearance().bounces = true}
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    HStack{
                        Image("netflix")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 32)
                        Spacer()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack{
                        NavigationLink(
                            destination: SearchContentView()
                            .toolbar(.hidden, for: .tabBar)
                        ) {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(Color.white)
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        ZStack{
            VStack {
                WebImage(url: viewModel.bannerImage)
                    .resizable()
                    .placeholder(Image("placeholder"))
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay {
                        ZStack(alignment: .bottom){
                            LinearGradient(colors: [.black.opacity(0.1),.clear,.black.opacity(0.1),.black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            HStack(spacing: 20){
                                topButtonView(type: .play, image: "play.fill", title: "Play")
                                topButtonView(type: .add, image: "plus", title: "My List")
                            }
                            .padding(.horizontal,20)
                            .padding(.bottom)
                        }
                    }
            }
        }
            
    }
    
    @ViewBuilder
    private func listView(size: CGSize) -> some View {
        ForEach(viewModel.homeSection) { section in
            VStack(spacing:15){
                HStack{
                    Text(section.id.capitalizesFirst())
                        .foregroundStyle(Color.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .shimmering(active: viewModel.isloading, animation: .bouncy)
                }
                .padding(.horizontal,15)
                ScrollView(.horizontal) {
                    HStack(spacing: 12){
                        switch section {
                        case .trendingMovies(let movies):
                            navigateToPlayer(model: movies, size: size)
                        case .trendingTv(let tv):
                            navigateToPlayer(model: tv, size: size)
                        case .popular(model: let popular):
                            navigateToPlayer(model: popular, size: size)
                        case .upComing(let upComing):
                            navigateToPlayer(model: upComing, size: size)
                        case .topRate(let topRated):
                            navigateToPlayer(model: topRated, size: size)
                        }
                        
                    }
                    .padding(.horizontal,15)
                }
                .scrollIndicators(.hidden)
            }
        }

    }
    
    private func imageView(size : CGSize, url: String) -> some View {
        WebImage(url: URL(string: Constant.imageURL+url))
            .placeholder(Image("placeholder"))
            .resizable()
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: size.width/2.8,height: isiPad() ? size.height/2.8 : size.height/3.5)
            .background(RoundedRectangle(cornerRadius: 10))
            .shimmering(active: viewModel.isloading, animation: .bouncy)
    }
    
    @ViewBuilder
    private func navigateToPlayer(model: [MovieDetailModel], size : CGSize) -> some View {
        ForEach(model, id: \.self) { model in
            imageView(size: size, url: model.poster_path ?? "")
        }
    }
    
    
    @ViewBuilder
    private func topButtonView(type: TopButtonType, image: String , title: String) -> some View {
        HStack(spacing: 12){
            Image(systemName: image)
                .fontWeight(.bold)
                .foregroundStyle(type == .play ? .black : .white)
                .frame(width: 15, height: 15)
            Text(title)
                .foregroundStyle(type == .play ? .black : .white)
                .font(.headline)
                .fontWeight(.semibold)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical,10)
        .background(type == .play ? .white : .white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
}

#Preview {
    HomeContentView()
}
