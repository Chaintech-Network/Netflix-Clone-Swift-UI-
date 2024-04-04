//
//  TabBar.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 30/12/23.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            GamesContentView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }
                .tag(1)
            
            NewHotView()
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("News & Hot")
                }
                .tag(2)
            
            SampleView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("My Netflix")
                }
                .tag(3)
        }
    }
}

struct SampleView: View {
    var body: some View {
        Text("Hello World!")
    }
}

#Preview {
    TabBar()
}
