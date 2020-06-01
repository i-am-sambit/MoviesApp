//
//  MoviesHomeViewModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 26/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine

struct Category: Identifiable {
    let id: Int
    let name: String
    let movies: [MovieBaseProtocol]
}

class MoviesHomeViewModel: ObservableObject {
    let objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    
    var shouldShowActivityIndicator: Bool {
        return categories.count < 4
    }
    
    var categories: [Category] = [] {
        didSet {
            self.categories.sort { $0.id < $1.id }
            self.objectWillChange.send()
        }
    }
    
    init() {
        fetchTrendingMovies()
        
        fetchPopularMovies()
        fetchNowPlayingMovies()
        fetchUpcomingMovies()
        fetchTopRatedMovies()
    }
    
    
    private func fetchTrendingMovies() {
        WebServiceHandler.shared.fetchTrendingMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    self.categories.append(Category(id: CategoryId.trending.rawValue,
                                                      name: CategoryTitle.trending.rawValue,
                                                      movies: response.results))
                    break
                case .failure(let error):
                    print("Unable to fetch movies : \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    private func fetchPopularMovies() {
        WebServiceHandler.shared.fetchPopularMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    self.categories.append(Category(id: CategoryId.popular.rawValue,
                                                      name: CategoryTitle.popular.rawValue,
                                                      movies: response.results))
                    break
                case .failure(let error):
                    print("Unable to fetch movies : \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    private func fetchNowPlayingMovies() {
        WebServiceHandler.shared.fetchNowPlayingMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    self.categories.append(Category(id: CategoryId.nowPlaying.rawValue,
                                                      name: CategoryTitle.nowPlaying.rawValue,
                                                      movies: response.results))
                    break
                case .failure(let error):
                    print("Unable to fetch movies : \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    private func fetchUpcomingMovies() {
        WebServiceHandler.shared.fetchUpcomingMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    self.categories.append(Category(id: CategoryId.upcoming.rawValue,
                                                      name: CategoryTitle.upcoming.rawValue,
                                                      movies: response.results))
                    break
                case .failure(let error):
                    print("Unable to fetch movies : \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    private func fetchTopRatedMovies() {
        WebServiceHandler.shared.fetchTopRatedMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    self.categories.append(Category(id: CategoryId.topRated.rawValue,
                                                      name: CategoryTitle.topRated.rawValue,
                                                      movies: response.results))
                    break
                case .failure(let error):
                    print("Unable to fetch movies : \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    private func fetchTvTodaysAiring() {
//        WebServiceHandler.shared.fetchTvTodaysAiring { (result) in
//            DispatchQueue.main.async {
//                switch result {
//
//                case .success(let response):
//                    let tvAiringToday = response.results
//                    self.categories.append(Categories(id: 0, name: "Airing Today", movies: tvAiringToday))
//                    break
//                case .failure(_):
//                    break
//                }
//            }
//        }
    }
    
    private func fetchTvOnTheAir() {
//        WebServiceHandler.shared.fetchTvOnTheAir { (result) in
//            DispatchQueue.main.async {
//                switch result {
//
//                case .success(let response):
//                    let tvOnAir = response.results
//                    self.categories.append(Categories(id: 1, name: "On Air", movies: tvOnAir))
//                    break
//                case .failure(_):
//                    break
//                }
//            }
//        }
    }
    
    private func fetchTvPopular() {
//        WebServiceHandler.shared.fetchTvPopular { (result) in
//            DispatchQueue.main.async {
//                switch result {
//
//                case .success(let response):
//                    let tvPopular = response.results
//                    self.categories.append(Categories(id: 2, name: "Popular", movies: tvPopular))
//                    break
//                case .failure(_):
//                    break
//                }
//            }
//        }
    }
    
    private func fetchTvTopRated() {
//        WebServiceHandler.shared.fetchTvTopRated { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                    
//                case .success(let response):
//                    let tvTopRated = response.results
//                    self.categories.append(Categories(id: 3, name: "Top Rated", movies: tvTopRated))
//                    break
//                case .failure(_):
//                    break
//                }
//            }
//        }
    }
    
}

extension MoviesHomeViewModel {
    private enum CategoryId: Int {
        case trending
        case nowPlaying
        case popular
        case upcoming
        case topRated
        case geners
        case action
        case romantic
        case thriller
        case horror
    }
    
    private enum CategoryTitle: String {
        case trending = "Trending today"
        case nowPlaying = "In Theater"
        case popular = "Popular"
        case upcoming = "Upcoming"
        case topRated = "Top Rated"
        case geners = "Geners"
        case action = "Action"
        case romantic = "Romance"
        case thriller = "Thriller"
        case horror = "Horror"
    }
}
