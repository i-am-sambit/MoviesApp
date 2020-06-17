//
//  MovieUIView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    @State var moveToTrailer: Bool = false
    @State var willBookTicket: Bool = false
    
    init(movie: MovieBaseProtocol) {
        viewModel = MovieDetailsViewModel(movie: movie.id)
        
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UINavigationBar.appearance().backgroundColor = UIColor(named: "SecondaryBackgroundColor")?.withAlphaComponent(0.2)
        UINavigationBar.appearance().isOpaque = false
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if viewModel.movie != nil {
                VStack {
                    List {
                        VStack(alignment: .leading) {
                            ZStack(alignment: .bottomTrailing) {
                                URLImageView(urlString: viewModel.movie!.posterPath)
                                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                
                                GradientView()
                                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), .clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom))
                                
                                DetailsRatingView(totalRating: viewModel.movie!.rating, popularity: viewModel.movie!.popularity)
                                    .background(Color.clear)
                                    .shadow(color: Color.shadowBackgroundColor, radius: 25)
                                    .padding(.bottom, -40)
                            }
                            .padding(.top, -10)
                            .padding(.horizontal, -20)
                            
                            Text(viewModel.movie!.title)
                                .font(.title)
                                .padding(.top, 60)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(self.viewModel.movie!.genres, id: \.id) { genre in
                                        GenerView(genre: genre)
                                            .padding(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.shadowBackgroundColor, lineWidth: 2)
                                        )
                                    }
                                }
                            }
                            
                            Text(viewModel.movie!.overview)
                                .font(.system(size: 17))
                                .foregroundColor(.primary)
                                .padding(.vertical)
                            
                            Divider()
                                .padding(.horizontal, -20)
                                .background(Color.secondary)
                            MovieCastView(casts: viewModel.casts)
                            
                            Divider()
                                .padding(.horizontal, -20)
                                .background(Color.secondary)
                            SimilarMoviesView(movies: viewModel.similarMovies)
                        }
                    }
                    
                    NavigationLink(destination: TheaterView(), isActive: self.$willBookTicket) {
                        Text("BOOK TICKET")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .frame(minWidth: 400, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color.red)
                }
            } else {
                LoaderView(isAnimating: true)
            }
        }
        .background(Color.backgroundColor)
        .navigationBarTitle("", displayMode: .inline)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            self.viewModel.fetchDetails()
            self.viewModel.fetchCredits()
            self.viewModel.fetchSimilarMovies()
        }
        .alert(isPresented: Binding<Bool>(
            get: { (self.viewModel.error != nil) },
            set: { _ in }
        )) {
            Alert(
                title: Text("Error!"),
                message: Text(self.viewModel.error?.localizedDescription ?? "")
            )
        }
    }
}

struct DetailsRatingView: View {
    var totalRating: String
    var popularity: Int
    
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            VStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.headline)
                    .frame(width: 20, height: 20)
                Text("\(totalRating) / 10")
            }
            Spacer()
            Button(action: {
                //FIXME: set rate
            }) {
                VStack {
                    Image(systemName: "star")
                        .foregroundColor(.gray)
                        .font(.headline)
                        .frame(width: 20, height: 20)
                    Text("Rate")
                        .foregroundColor(.primary)
                }
            }.frame(width: 50)
            
            Spacer()
            VStack {
                Text("\(popularity)")
                    .foregroundColor(.white)
                    .frame(height: 30)
                    .padding(.horizontal, 5)
                    .background(Color.green)
                    .cornerRadius(5)
                Text("Popularity")
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width - 100, height: 80)
        .background(Color.backgroundColor)
        .cornerRadius(radius: 40, corners: [.topLeft, .bottomLeft])
    }
}

struct GenerView: View {
    var genre: MovieGenre
    
    var body: some View {
        Text(genre.name)
            .font(.headline)
            .foregroundColor(.gray)
            
    }
}

struct MovieCastView: View {
    var casts: [MovieCastModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cast")
                .font(.system(size: 22, weight: .bold))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(casts, id: \.id) { cast in
                        NavigationLink(destination: ActorProfileView(cast: cast)) {
                            MovieCastCardView(cast: cast)
                        }
                    }
                }
            }
        }
    }
}

struct SimilarMoviesView: View {
    var movies: [MovieBaseProtocol]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Similar Movies")
                .font(.system(size: 22, weight: .bold))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie)) {
                            MovieCardView(movie: movie)
                        }
                    }
                }
            }
        }
    }
}

struct MovieUIView_Previews: PreviewProvider {
    static let movie = Movie(id: 99861,
                             name: "Think Like a Dog",
                             overview: "A 12-year-old tech prodigy whose science experiment goes awry and he forges a telepathic connection with his best friend, his dog. The duo join forces and use their unique perspectives on life to comically overcome complications of family and school.",
                             poster: "/cDbOrc2RtIA37nLm0CzVpFLrdaG.jpg",
                             releaseDate: "2020-06-05",
                             rating: 8,
                             popularity: 47)
    
    static var previews: some View {
        Group {
//            MovieDetailsView(movie: movie)
//                .previewDevice(.init(rawValue: "iPhone 11 Pro Max"))
//                .previewDisplayName("iPhone 11 Pro Max - Light Mode")
//                .environment(\.colorScheme, .light)

            MovieDetailsView(movie: movie)
                .previewDevice(.init(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Dark Mode")
                .environment(\.colorScheme, .dark)
//
//            MovieDetailsView(movie: movie)
//                .previewDevice(.init(rawValue: "iPhone 8 Plus"))
//                .previewDisplayName("iPhone 8 Plus - Dark Mode")
//                .environment(\.colorScheme, .dark)
//
//            MovieDetailsView(movie: movie)
//                .previewDevice(.init(rawValue: "iPhone SE (2nd generation)"))
//                .previewDisplayName("iPhone SE (2nd generation) - Dark Mode")
//                .environment(\.colorScheme, .dark)
            
//            MovieDetailsView(movie: movie)
//                .previewDevice(.init(rawValue: "iPad Pro (9.7-inch)"))
//                .previewDisplayName("iPad Pro (9.7-inch) - Dark Mode")
//                .environment(\.colorScheme, .dark)
        }
    }
}
