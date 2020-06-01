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
        UITableView.appearance().tableHeaderView = UIView()
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    @State var showingProfile = false
    @State var showHambergerMenu: Bool = false
    @State var showMore: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        CategoryTabView()
    }
}

struct MovieHomeView: View {
    @ObservedObject var moviesDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            List {
                ForEach(self.moviesDataSource.categories) { category in
                    MovieCategoryCell(category: category)
                }
            }.padding(.top, -44)
        }
    }
}


struct MovieCategoryCell: View {
    @State private var x: CGFloat = 0
    @State private var count: CGFloat = 0
    @State private var screen = UIScreen.main.bounds.size.width - 30
    var category: Category
    
    var body: some View {
        VStack(alignment: .leading) {
            if category.id != 0 {
                HStack {
                    Text(category.name)
                        .font(.title)
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: {
                    }) {
                        Text("See More")
                    }
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                if category.id == 0 {
                    HStack {
                        ForEach(self.category.movies, id: \.id) { movie in
                            NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                TrendingMovieCard(movie: movie)
                                    .offset(x: self.x)
                                    .highPriorityGesture(DragGesture()
                                        .onChanged({ (value) in
                                            if value.translation.width > 0 {
                                                self.x = value.location.x
                                            } else {
                                                self.x = value.location.x - self.screen
                                            }
                                        })
                                        .onEnded({ (value) in
                                            if value.translation.width > 0 {
                                                if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != self.getMid() {
                                                    self.count += 1
                                                    self.x = (self.screen + 15) * self.count
                                                } else {
                                                    self.x = (self.screen + 15) * self.count
                                                }
                                            } else {
                                                if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != self.getMid() {
                                                    self.count -= 1
                                                    self.x = (self.screen + 15) * self.count
                                                } else {
                                                    self.x = (self.screen + 15) * self.count
                                                }
                                            }
                                        }))
                            }
                        }
                    }
                } else {
                    HStack {
                        ForEach(self.category.movies, id: \.id) { movie in
                            NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                MovieCard(movie: movie)
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom, 0)
    }
    
    private func getMid() -> Int {
        return self.category.movies.count/2
    }
}

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
        Group {
            MovieDBHomeView()
            .previewDisplayName("iPhone 11 Pro Max - Dark Mode")
                .environment(\.colorScheme, .dark)
            
            MovieDBHomeView()
                .previewDisplayName("iPhone 11 Pro Max - Light Mode")
                .environment(\.colorScheme, .light)
        }
    }
}
