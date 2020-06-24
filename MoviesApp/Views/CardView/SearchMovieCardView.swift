//
//  SearchMovieCardView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 20/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct SearchMovieCardView: View {
    var movie: MovieBaseProtocol
    
    var body: some View {
        HStack {
            URLImageView(urlString: self.movie.poster)
                .frame(width: (UIScreen.main.bounds.size.width * 0.4), height: (UIScreen.main.bounds.size.width * 0.4))
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.name)
                    .font(.system(size: 22))
                StarRatingView(rating: Float(movie.rating))
                    .foregroundColor(.yellow)
                Text(movie.releaseDate)
                    .font(.system(size: 16))
                    .padding(.vertical)
            }
            
            Spacer()
        }
        .background(Color.backgroundColor)
        .cornerRadius(10)
        .padding(.vertical)
    }
}

struct StarRatingView: View {
    private let rating: Float
    private let fullStar: Int
    private let halfStar: Int
    private let emptyStar: Int
    
    init(rating: Float) {
        self.rating = rating
        
        self.fullStar = Int(round(rating)/2)
        self.halfStar = (Int(round(rating))%2) == 0 ? 0 : 1
        self.emptyStar = (5 - (self.fullStar + halfStar))
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0 ..< fullStar) { item in
                Image(systemName: "star.fill")
            }
            
            ForEach(0 ..< halfStar) { item in
                Image(systemName: "star.lefthalf.fill")
            }
            
            ForEach(0 ..< emptyStar) { item in
                Image(systemName: "star")
            }
            
            Text(String(format: "%.1f", rating))
                .foregroundColor(.white)
                .frame(height: 30)
                .padding(.horizontal, 5)
                .background(Color.green)
                .cornerRadius(5)
        }
    }
}

struct SearchMovieCardView_Previews: PreviewProvider {
    static let movie = Movie(id: 99861,
                             name: "Think Like a Dog",
                             overview: "A 12-year-old tech prodigy whose science experiment goes awry and he forges a telepathic connection with his best friend, his dog. The duo join forces and use their unique perspectives on life to comically overcome complications of family and school.",
                             poster: "/4q2NNj4S5dG2RLF9CpXsej7yXl.jpg",
                             releaseDate: "2020-06-05",
                             rating: 7.7,
                             popularity: 47)
    
    static var previews: some View {
        SearchMovieCardView(movie: movie)
            .environment(\.colorScheme, .dark)
    }
}
