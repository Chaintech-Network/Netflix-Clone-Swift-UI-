//
//  SearchView.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 31/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    
    var gridItemLayout = [
        GridItem(.adaptive(minimum: 150, maximum: 150)),
        GridItem(.adaptive(minimum: 150, maximum: 150)),
        GridItem(.adaptive(minimum: 150, maximum: 150))
    ]
    
    @Binding var searchModel : [MovieDetailModel]
    @Binding var isLoading : Bool 
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout,spacing: 15 ,content: {
                ForEach(searchModel, id: \.self) { model in
                    WebImage(url: URL(string: Constant.imageURL+(model.poster_path ?? "")))
                        .resizable()
                        .placeholder(Image("placeholder"))
                        .frame(height: 200)
                        .shimmering(active: isLoading, animation: .bouncy)
                }
            })
            .padding(.horizontal,10)
        }
    }
}

#Preview {
    SearchView(searchModel: .constant([]), isLoading: .constant(false))
}
