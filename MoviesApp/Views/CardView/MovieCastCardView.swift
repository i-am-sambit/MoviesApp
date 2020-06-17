//
//  MovieCastCardView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 15/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct MovieCastCardView: View {
    var cast: MovieCastModel
    
    var body: some View {
        VStack(alignment: .leading) {
            URLImageView(urlString: cast.posterPath, placeHolder: Image(systemName: "person.fill"))
                .frame(width: 180, height: 180)
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(cast.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(cast.character)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .frame(width: 180, height: 280)
        .padding(.trailing)
    }
}

struct MovieCastCardView_Previews: PreviewProvider {
    static let cast = MovieCastModel(castId: 379, character: "Peter Parker / Spider-Man", creditId: "5d3ef9e934e1525dace8b35c", gender: 2, id: 1136406, name: "Tom Holland", order: 0, posterPath: "")
    
    static var previews: some View {
        MovieCastCardView(cast: cast)
            .environment(\.colorScheme, .dark)
    }
}
