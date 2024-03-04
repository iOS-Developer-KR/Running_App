//
//  HeaderView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/28/23.
//

import SwiftUI

struct HeaderView: View {
    let tmp = ["a","b","c","d","e"]
    var images = ["figure.basketball", "figure.core.training", "figure.indoor.cycle", "figure.mind.and.body"]
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { image in
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .fixedSize(horizontal: false, vertical: false)
                    .foregroundStyle(.white)
                    .padding(10)
                
            }
        }.tabViewStyle(PageTabViewStyle())
//            .foregroundStyle(.green)
            .background(.green)
        
    }
}

#Preview {
    HeaderView()
        .previewLayout(.sizeThatFits)
}
