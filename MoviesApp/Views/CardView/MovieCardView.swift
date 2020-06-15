//
//  MovieCardView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 15/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct MovieCardView: View {
    var movie: MovieBaseProtocol
    
    var body: some View {
        VStack() {
            URLImageView(urlString: movie.poster)
                .frame(width: 250, height: 180)
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(movie.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(movie.overview)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 250, height: 280)
        .padding(.trailing)
    }
    
}

struct MovieCardView_Previews: PreviewProvider {
    static let movie = Movie(id: 429617,
                             name: "Think Like a Dog",
                             overview: "A 12-year-old tech prodigy whose science experiment goes awry and he forges a telepathic connection with his best friend, his dog. The duo join forces and use their unique perspectives on life to comically overcome complications of family and school.",
                             poster: "/cDbOrc2RtIA37nLm0CzVpFLrdaG.jpg",
                             releaseDate: "2020-06-05",
                             rating: 8,
                             popularity: 47)
    
    static var previews: some View {
        MovieCardView(movie: movie)
    }
}
