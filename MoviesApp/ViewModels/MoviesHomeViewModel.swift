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
    var trendingSubscription: AnyCancellable?
    var popularSubscription: AnyCancellable?
    var nowPlayingSubscription: AnyCancellable?
    var upcomingSubscription: AnyCancellable?
    var topRatedSubscription: AnyCancellable?
    
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
        do {
            self.trendingSubscription = try WebServiceHandler().fetchTrendingMovies()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completionHandler in
                    
                }, receiveValue: { (response) in
                    self.categories.append(Category(id: CategoryId.trending.rawValue,
                                                    name: CategoryTitle.trending.rawValue,
                                                    movies: response.results))
                })
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchPopularMovies() {
        do {
            self.popularSubscription = try WebServiceHandler().fetchPopularMovies()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completionHandler in
                    
                }, receiveValue: { (response) in
                    self.categories.append(Category(id: CategoryId.popular.rawValue,
                                                    name: CategoryTitle.popular.rawValue,
                                                    movies: response.results))
                })
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchNowPlayingMovies() {
        do {
            self.nowPlayingSubscription = try WebServiceHandler().fetchNowPlayingMovies()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completionHandler in
                    
                }, receiveValue: { (response) in
                    self.categories.append(Category(id: CategoryId.nowPlaying.rawValue,
                                                    name: CategoryTitle.nowPlaying.rawValue,
                                                    movies: response.results))
                })
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchUpcomingMovies() {
        do {
            self.upcomingSubscription = try WebServiceHandler().fetchUpcomingMovies()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completionHandler in
                    
                }, receiveValue: { (response) in
                    self.categories.append(Category(id: CategoryId.upcoming.rawValue,
                                                    name: CategoryTitle.upcoming.rawValue,
                                                    movies: response.results))
                })
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Fetch top rated movies
    private func fetchTopRatedMovies() {
        do {
            self.topRatedSubscription = try WebServiceHandler().fetchTopRatedMovies()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completionHandler in
                    
                }, receiveValue: { (response) in
                    self.categories.append(Category(id: CategoryId.topRated.rawValue,
                                                    name: CategoryTitle.topRated.rawValue,
                                                    movies: response.results))
                })
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchTvTodaysAiring() {
    }
    
    private func fetchTvOnTheAir() {
    }
    
    private func fetchTvPopular() {
    }
    
    private func fetchTvTopRated() {
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
