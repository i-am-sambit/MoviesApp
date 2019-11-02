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
    
    @State var showingProfile = false
    @State var showingHambergerMenu = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            HomeView()
            
            HumbergerMenu()
                .frame(width: 300)
                .offset(x: -300)
        }
    }
}

struct HomeView: View {
    var body: some View {
        TabView {
            MovieHomeView()
            .tabItem {
                Text("Movies")
                Image(systemName: "film")
            }
            
            TVHomeView()
            .tabItem {
                Text("TV Series")
                Image(systemName: "tv")
            }
        }
    }
}

struct MovieHomeView: View {
    @ObservedObject var moviesDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                    .frame(height: 50.0)
                
                ScrollView(showsIndicators: false) {
                    MovieCategoryCell(category: "Now Playing", movies: moviesDataSource.nowPlayingMovies)
                    MovieCategoryCell(category: "Popular", movies: moviesDataSource.popularMovies)
                    MovieCategoryCell(category: "Upcoming", movies: moviesDataSource.upcomingMovies)
                    MovieCategoryCell(category: "Top Rated", movies: moviesDataSource.topRatedMovies)
                }
            }
            .navigationBarTitle("Movies App")
            .navigationBarHidden(true)
        }
    }
}

struct TVHomeView: View {
    @ObservedObject var tvDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                .frame(height: 50.0)
                
                ScrollView(showsIndicators: false) {
                    MovieCategoryCell(category: "TV Airing Today", movies: tvDataSource.tvAiringToday)
                    MovieCategoryCell(category: "TV on the Air", movies: tvDataSource.tvOnAir)
                    MovieCategoryCell(category: "Popular", movies: tvDataSource.tvPopular)
                    MovieCategoryCell(category: "Top Rated", movies: tvDataSource.tvTopRated)
                }
            }
            .navigationBarTitle("Movies App")
            .navigationBarHidden(true)
        }
    }
}

struct MovieCategoryCell: View {
    var category: String
    var movies:  [MovieBaseProtocol]
    
    init(category: String, movies: [MovieBaseProtocol]) {
        self.category = category
        self.movies = movies
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.movies, id: \.id) { movie in
                        NavigationLink(destination: MovieUIView(movie: movie)) {
                            MovieCard(movie: movie)
                        }
                    }
                }
            }
            .frame(height: 280)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct MovieCard: View {
    var movie: MovieBaseProtocol
    
    init(movie: MovieBaseProtocol) {
        self.movie = movie
    }
    
    var body: some View {
        VStack() {
            URLImageView(urlString: movie.poster)
                .frame(width: 250, height: 180)
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(10)
                .shadow(color: .primary, radius: 5, x: 0, y: 0)
            
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
