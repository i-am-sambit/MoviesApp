//
//  MovieListView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 04/11/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var moviesDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    var body: some View {
        List {
            ForEach(self.moviesDataSource.nowPlayingMovies, id: \.id) { movie in
//                NavigationLink(destination: MovieUIView(movie: movie)) {
                    MovieCell(movie: movie)
//                }
            }
        }
        .navigationBarTitle("Now Playing", displayMode: .inline)
    }
}

struct MovieCell: View {
    var movie: MovieBaseProtocol
    
    var body: some View {
        VStack {
            URLImageView(urlString: movie.poster)
                .frame(height: 250)
                .aspectRatio(contentMode: .fill)
                .clipped()
                
            Text(movie.name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
            Text(movie.overview)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(width: UIScreen.main.bounds.width, height: 350)
        .padding(.horizontal, -20)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
