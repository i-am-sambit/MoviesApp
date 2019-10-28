//
//  ContentView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 25/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    @ObservedObject var moviesDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    var body: some View {
        NavigationView {
            List {
                MovieCategoryCell(category: "Now Playing", movies: moviesDataSource.nowPlayingMovies)
                MovieCategoryCell(category: "Popular", movies: moviesDataSource.popularMovies)
                MovieCategoryCell(category: "Upcoming", movies: moviesDataSource.upcomingMovies)
                MovieCategoryCell(category: "Top Rated", movies: moviesDataSource.topRatedMovies)
            }
            .navigationBarTitle("Movies")
        }
    }
}

struct MovieCategoryCell: View {
    var category: String
    var movies:  [Movie]
    
    init(category: String, movies: [Movie]) {
        self.category = category
        self.movies = movies
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.movies, id: \.movieID) { movie in
                        NavigationLink(
                            destination: MovieUIView(movie: movie)
                        ) {
                            MovieCard(movie: movie)
                        }
                    }
                }
            }
            .frame(height: 280)
            .padding(.leading, -10)
            .padding(.trailing, -10)
        }
    }
}

struct MovieCard: View {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        VStack() {
            URLImageView(urlString: movie.poster)
                .frame(width: 250, height: 180)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                .clipped()
                
            VStack(alignment: .leading) {
                Text(movie.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(movie.overview)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 250, height: 280)
        .padding(.trailing)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
