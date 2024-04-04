//
//  SplashScreenView.swift
//  NetflixClone
//
//  Created by Abhishek Tyagi on 02/04/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SplashScreenView: View {
    
    @State var isShowSplash: Bool = true
    
    var body: some View {
        ZStack(content: {
            if isShowSplash {
                AnimatedImage(url: URL(string: "https://c.tenor.com/y9wRo5oAad4AAAAC/tenor.gif"))
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }else{
                TabBar()
            }
        })
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.isShowSplash = false
                }
            }
        }

    }
}

#Preview {
    SplashScreenView()
}
