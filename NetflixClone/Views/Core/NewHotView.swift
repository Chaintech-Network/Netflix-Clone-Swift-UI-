//
//  NewHotView.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 04/02/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewHotView: View {
    
    @StateObject private var viewModel : NewHotViewModel
    @Namespace private var animation
    
    init(viewModel: NewHotViewModel = NewHotViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 15, content: {
                HStack{
                    Text("News & Hot")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(
                        destination: SearchContentView()
                            .toolbar(.hidden, for: .tabBar)
                    ) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.white)
                            .font(.title3)
                    }
                }
                .padding(.horizontal,15)
                tagViews()
                listView()
            })
        }
    }
    
    // Tag View
    @ViewBuilder
    private func tagViews() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10, content: {
                ForEach(viewModel.homeSection, id: \.self) { model in
                    Text(model.id.capitalizesFirst())
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundStyle(model.id == viewModel.activeTag ? .black : .white)
                        .padding(.horizontal,12)
                        .padding(.vertical,8)
                        .background{
                            if model.id == viewModel.activeTag {
                                Capsule()
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }else{
                                Capsule()
                                    .stroke(.gray,lineWidth: 1.0)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                viewModel.activeTag = model.id
                                viewModel.fetchUserRecomendation(list: model)
                            }
                        }
                }
            })
            .padding(.horizontal,20)
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func listView() -> some View {
        ScrollView {
            ForEach(viewModel.newHotModel, id: \.self) { model in
                recomendationView(resp: model)
            }
            
        }
    }
    
    @ViewBuilder
    private func recomendationView(resp: MovieDetailModel) -> some View {
        GeometryReader{
            let size = $0.size
            VStack(content: {
                HStack(alignment: .top ,spacing: 10, content: {
                    dateView(date: resp.release_date ?? "")
                    Spacer()
                    WebImage(url: URL(string: Constant.imageURL+(resp.poster_path ?? "")))
                        .placeholder(Image("placeholder"))
                        .resizable()
                        .scaledToFill()
                        .frame(height: size.height - 20)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                })
            })
            .padding(.horizontal,15)
            .padding(.vertical,20)
            .shimmering(active: viewModel.isloading)
            
        }
        .frame(height: 450)
    }
    
    @ViewBuilder
    private func dateView(date: String) -> some View {
        VStack(alignment: .leading,spacing: 8, content: {
            Text(viewModel.handlerDate(dateString: date,format: "MMM"))
                .font(.footnote)
                .fontWeight(.semibold)
            Text(viewModel.handlerDate(dateString: date, format: "d"))
                .font(.title)
                .fontWeight(.semibold)
        })
        .padding(.top,5)
    }
}

#Preview {
    NewHotView()
}
