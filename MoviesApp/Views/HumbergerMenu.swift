//
//  HumbergerMenu.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 01/11/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct HumbergerMenu: View {
    var body: some View {
        List {
            ZStack(alignment: .bottomLeading) {
                Image("avengers")
                    .resizable()
                    .frame(height: 250)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                Text("Jhon Doe")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
            .frame(minWidth: 50, maxWidth: .infinity, minHeight: 250, alignment: .bottomLeading)
            .padding(.horizontal, -16)
            
            HStack {
                Image(systemName: "film")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("Movies")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            HStack {
                Image(systemName: "tv")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("TV Series")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .statusBar(hidden: false)
    }
}

struct HumbergerMenu_Previews: PreviewProvider {
    static var previews: some View {
        HumbergerMenu()
    }
}
