//
//  SearchContentView.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 31/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchContentView: View {
    
    @ObservedObject private var viewModel : SearchViewModel
    @Environment (\.dismiss) private var dismiss
    
    init(viewModel: SearchViewModel = SearchViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0, content: {
                VStack(spacing: 20){
                    HStack{
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                                .font(.title)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.horizontal,20)
                        })
                    }
                    searchBar
                    if viewModel.searchTxt.isEmpty{
                        suggestionView
                    }else{
                        withAnimation(.easeIn(duration: 0.3)) {
                            SearchView(searchModel: $viewModel.searchDetail, isLoading: $viewModel.isSearching)
                        }
                    }
                    
                }

            })
            .onChange(of: viewModel.searchTxt) { oldValue, newValue in
                Task{
                    try await viewModel.getSearch()
                }
            }
 

        }.navigationBarBackButtonHidden()
    }
    
    // Search View
    var searchBar: some View {
        HStack(spacing: 10, content: {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.white.opacity(0.7))
                .frame(width: 15, height: 15)
            
            TextField("Search games, shows, movies...", text: $viewModel.searchTxt)
                .font(.title3)
                .fontWeight(.semibold)
                .tint(.white)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "mic")
                    .foregroundStyle(Color.white.opacity(0.7))
                    .frame(width: 15, height: 15)
            })
        })
        .padding(.horizontal,20)
        .padding(.vertical,15)
        .background(Color(uiColor: .systemGray3))
    }
    
    // Suggestion View
    var suggestionView: some View {
        GeometryReader{
            let size = $0.size
            ScrollView {
                VStack(spacing: 15, content: {
                    ForEach(viewModel.discoverModel, id: \.self) {
                        suggestList(list: $0)
                            .shimmering(active: viewModel.isLoading,animation: .bouncy)
                    }
                })
                .padding(.horizontal,15)
                .padding(.vertical,20)
                .padding(.bottom,bottomPadding(size))
                .background{
                    ScrollViewDetector(totalCardCount: viewModel.discoverModel.count)
                }
            }
            .scrollIndicators(.never)
            .coordinateSpace(name: "SCROLLVIEW")
        }
        .padding(.top,15)
    }
    
    @ViewBuilder
    private func suggestList(list: MovieDetailModel) -> some View {
        GeometryReader{
            let size = $0.size
            let rect = $0.frame(in: .named("SCROLLVIEW"))
            
            HStack(spacing: -25, content: {
                VStack(alignment: .center,spacing: 6, content: {
                    Text(list.title ?? "")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    RatingView(rating: list.vote_average ?? 0.0)
                        .padding(.top,10)
                    
                    if isiPad() {
                        Spacer(minLength: 10)
                        Text(list.overview ?? "")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                    }
                
                    Spacer(minLength: 10)
                    HStack(spacing: 4){
                        Text(String(format: "%.0f", list.popularity ?? 0.0))
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                        Text("Views")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.gray)

                    }

                    
                })
                .padding(20)
                .frame(width: size.width/2 , height: size.height * 0.8 )
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.black)
                        .shadow(color: .white.opacity(0.11), radius: 8,x: 5, y: 5)
                        .shadow(color: .white.opacity(0.11), radius: 8,x: -5, y: -5)
                }
                .zIndex(1)
                
                ZStack{
                    WebImage(url: URL(string: Constant.imageURL+(list.poster_path ?? "")))
                        .resizable()
                        .placeholder(Image("placeholder"))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width/2, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: .white.opacity(0.09), radius: 8,x: 5, y: 5)
                        .shadow(color: .white.opacity(0.09), radius: 8,x: -5, y: -5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            })
            .frame(width: size.width)
            .rotation3DEffect(.init(degrees: convertOffSetRotation(rect)),axis: (x: 1, y: 0, z: 0),anchor: .bottom, anchorZ: 1, perspective: 0.8)
        }
        .frame(height: isiPad() ? 650 : 220)
    }
    
    // Convert OffSet Rotation
    private func convertOffSetRotation(_ rect: CGRect) -> Double {
        let cardHeight = rect.height + 20
        let minY = rect.minY - 20
        let progress = minY < 0 ? (minY / cardHeight) : 0
        let constrainedProgress = min(-progress, 1.0)
        return (constrainedProgress * 90)
    }
    
    // Bottom Padding
    private func bottomPadding(_ size: CGSize = .zero) -> CGFloat {
        let cardHeight: CGFloat = 220
        let scrollHeight: CGFloat = size.height
        
        return scrollHeight - cardHeight - 20
    }
    
}

struct RatingView: View {
    
    var rating: Float
    
    var body: some View {
        HStack(spacing: 4, content: {
            ForEach(0..<5, id: \.self) { index in
                let indie = Float(index)
                Image(systemName: "star.fill")
                    .font(.caption2)
                    .foregroundStyle(indie <= (rating/2.5) ? .yellow : .gray.opacity(0.5))
                    
            }
        })
    }
}

#Preview {
    SearchContentView()
}
