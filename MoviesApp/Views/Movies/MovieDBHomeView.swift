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
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MovieHomeView: View {
    @ObservedObject var moviesDataSource: MoviesHomeViewModel = MoviesHomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if moviesDataSource.shouldShowActivityIndicator {
                LoaderView(isAnimating: true)
            } else {
                HeaderView()
                List {
                    ForEach(self.moviesDataSource.categories) { category in
                        MovieCategoryCell(category: category)
                    }
                }
                .padding(.top, -44)
            }
        }
        .background(Color.backgroundColor)
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
                            }
                        }
                    }
                } else {
                    HStack {
                        ForEach(self.category.movies, id: \.id) { movie in
                            NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                MovieCardView(movie: movie)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieDBHomeView()
                .previewDevice(.init(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Dark Mode")
                .environment(\.colorScheme, .dark)
            
            MovieDBHomeView()
                .previewDevice(.init(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Light Mode")
                .environment(\.colorScheme, .light)
        }
    }
}
