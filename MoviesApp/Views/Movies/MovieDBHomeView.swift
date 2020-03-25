//
//  ContentView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 25/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct MovieDBHomeView: View {
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    @State var showingProfile = false
    @State var showHambergerMenu: Bool = false
    @State var showMore: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        HomeView(showHambergerMenu: self.$showHambergerMenu, showMore: self.$showMore)
    }
}

struct HomeView: View {
    @Binding var showHambergerMenu: Bool
    @Binding var showMore: Bool
    
    var body: some View {
        VStack {
            TabView {
                NavigationView {
                    MovieHomeView(showMore: $showMore)
                        .navigationBarTitle("Movies", displayMode: .automatic)
                }.tabItem {
                    Text("Movies")
                    Image(systemName: "film")
                }
                
                NavigationView {
                    TVHomeView(showMore: $showMore)
                        .navigationBarTitle("TV Series", displayMode: .automatic)
                }.tabItem {
                    Text("TV Series")
                    Image(systemName: "tv")
                }
            }
        }
    }
}

struct MovieHomeView: View {
    @ObservedObject var moviesDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    @Binding var showMore: Bool
    
    var body: some View {
        List {
            ForEach(self.moviesDataSource.movieCategories) { category in
                MovieCategoryCell(category: category.name,
                                  movies: category.movies,
                                  showMore: self.$showMore)
                
            }
        }
    }
}

struct TVHomeView: View {
    @ObservedObject var tvDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    @Binding var showMore: Bool
    
    var body: some View {
        VStack {
            List {
                ForEach(self.tvDataSource.tvCategories) { category in
                    MovieCategoryCell(category: category.name, movies: category.movies, showMore: self.$showMore)
                }
            }
        }
    }
}

struct MovieCategoryCell: View {
    var category: String
    var movies:  [MovieBaseProtocol]
    
    @Binding var showMore: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category)
                    .font(.title)
                    .foregroundColor(.primary)
                Spacer()
                Button(action: {
                    self.showMore.toggle()
                }) {
                    Text("See More")
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie)) {
                            MovieCard(movie: movie)
                            //                                .contextMenu {
                            //                                    Button(action: {
                            //                                        // change country setting
                            //                                    }) {
                            //                                        Text("Watch Trailer")
                            //                                        Image(systemName: "globe")
                            //                                    }
                            //
                            //                                    Button(action: {
                            //                                        // enable geolocation
                            //                                    }) {
                            //                                        Text("Detect Location")
                            //                                        Image(systemName: "location.circle")
                            //                                    }
                            //                            }
                        }
                    }
                }
                .frame(height: 280)
            }
        }
        .padding(.horizontal, 0)
    }
}

struct TrendingMovieCard: View {
    var movie: MovieBaseProtocol
    
    var body: some View {
        GeometryReader { geometryReader in
            ZStack() {
                URLImageView(urlString: self.movie.poster)
                    .frame(width: geometryReader.size.width - 20, height: 300)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(10)
                
                //            Text(movie.name)
                //                .font(.headline)
                //                .foregroundColor(.primary)
                //                .lineLimit(1)
            }
        }
        .frame(width: 500, height: 300)
        .padding(.trailing)
    }
}

struct MovieCard: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDBHomeView()
    }
}
