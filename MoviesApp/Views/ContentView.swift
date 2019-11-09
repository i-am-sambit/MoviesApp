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
    
    @State var showingProfile = false
    @State var showHambergerMenu: Bool = false
    @State var showMore: Bool = false
    @State var isLoading: Bool = false
    
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
            ZStack(alignment: .leading) {
                HomeView(showHambergerMenu: self.$showHambergerMenu, showMore: self.$showMore)
                
                if self.showHambergerMenu {
                    HumbergerMenu()
                        .frame(width: UIScreen.main.bounds.width)
                        .transition(.offset(x: (-UIScreen.main.bounds.width)))
                }
            }
            .navigationBarTitle("Movies App", displayMode: .inline)
            .navigationBarItems(leading: self.hambergerMenuButton)
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
        LoadingView(isShowing: .constant((moviesDataSource.movieCategories.count < 4))) {
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach(self.moviesDataSource.movieCategories) { category in
                        MovieCategoryCell(category: category.name, movies: category.movies, showMore: self.$showMore)
                    }
                }
            }
        }
    }
}

struct TVHomeView: View {
    @ObservedObject var tvDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    @Binding var showMore: Bool
    
    var body: some View {
        LoadingView(isShowing: .constant((tvDataSource.tvCategories.count < 4))) {
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach(self.tvDataSource.tvCategories) { category in
                        MovieCategoryCell(category: category.name, movies: category.movies, showMore: self.$showMore)
                    }
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
                        NavigationLink(destination: MovieUIView(movie: movie)) {
                            MovieCard(movie: movie)
                                .contextMenu {
                                    Button(action: {
                                        // change country setting
                                    }) {
                                        Text("Choose Country")
                                        Image(systemName: "globe")
                                    }

                                    Button(action: {
                                        // enable geolocation
                                    }) {
                                        Text("Detect Location")
                                        Image(systemName: "location.circle")
                                    }
                            }
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
