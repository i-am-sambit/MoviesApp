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
    @State var showHambergerMenu: Bool = false
    @State var showMore: Bool = false
    
    var hambergerMenuButton: some View {
        Button(action: {
            withAnimation {
                self.showHambergerMenu.toggle()
            }
            
        }) {
            Image(systemName: self.showHambergerMenu ? "chevron.left" : "line.horizontal.3")
                .imageScale(.large)
                .accessibility(label: Text("Hamberger Menu"))
                .padding()
                .foregroundColor(.primary)
        }
    }
    
    var body: some View {
        NavigationView {
//            NavigationLink(destination: MovieListView(), isActive: $showMore) {
            ZStack(alignment: .leading) {
                HomeView(showHambergerMenu: $showHambergerMenu, showMore: $showMore)
                
                if showHambergerMenu {
                    HumbergerMenu()
                        .frame(width: UIScreen.main.bounds.width)
                        .transition(.offset(x: (-UIScreen.main.bounds.width)))
                }
            }
//            }
            .navigationBarTitle("Movies App", displayMode: .inline)
            .navigationBarItems(leading: hambergerMenuButton)
        }
    }
}

struct HomeView: View {
    @Binding var showHambergerMenu: Bool
    @Binding var showMore: Bool
    
    var body: some View {
        VStack {
            TabView {
                MovieHomeView(showMore: $showMore)
                .tabItem {
                    Text("Movies")
                    Image(systemName: "film")
                }
                
                TVHomeView(showMore: $showMore)
                .tabItem {
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
            VStack {
            ScrollView(showsIndicators: false) {
                MovieCategoryCell(category: "Now Playing", movies: moviesDataSource.nowPlayingMovies, showMore: $showMore)
                MovieCategoryCell(category: "Popular", movies: moviesDataSource.popularMovies, showMore: $showMore)
                MovieCategoryCell(category: "Upcoming", movies: moviesDataSource.upcomingMovies, showMore: $showMore)
                MovieCategoryCell(category: "Top Rated", movies: moviesDataSource.topRatedMovies, showMore: $showMore)
            }
        }
    }
}

struct TVHomeView: View {
    @ObservedObject var tvDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    @Binding var showMore: Bool
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                MovieCategoryCell(category: "TV Airing Today", movies: tvDataSource.tvAiringToday, showMore: $showMore)
                MovieCategoryCell(category: "TV on the Air", movies: tvDataSource.tvOnAir, showMore: $showMore)
                MovieCategoryCell(category: "Popular", movies: tvDataSource.tvPopular, showMore: $showMore)
                MovieCategoryCell(category: "Top Rated", movies: tvDataSource.tvTopRated, showMore: $showMore)
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
                        NavigationLink(destination: MovieUIView(movie: movie)) {
                            MovieCard(movie: movie)
                        }
                    }
                }
            }
            .frame(height: 280)
        }
        .padding(.horizontal, 20)
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
        ContentView()
    }
}
