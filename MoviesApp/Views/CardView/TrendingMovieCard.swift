//
//  TrendingCardView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 15/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct TrendingMovieCard: View {
    var movie: MovieBaseProtocol
    
    var body: some View {
        URLImageView(urlString: self.movie.poster)
            .frame(width: UIScreen.main.bounds.size.width - 40, height: 300)
            .aspectRatio(contentMode: .fill)
            .clipped()
            .cornerRadius(10)
            .padding([.trailing, .top])
    }
}

struct TrendingMovieCard_Previews: PreviewProvider {
    static let movie = Movie(id: 429617,
                             name: "Think Like a Dog",
                             overview: "A 12-year-old tech prodigy whose science experiment goes awry and he forges a telepathic connection with his best friend, his dog. The duo join forces and use their unique perspectives on life to comically overcome complications of family and school.",
                             poster: "/cDbOrc2RtIA37nLm0CzVpFLrdaG.jpg",
                             releaseDate: "2020-06-05",
                             rating: 8,
                             popularity: 47)
    
    static var previews: some View {
        TrendingMovieCard(movie: movie)
    }
}
