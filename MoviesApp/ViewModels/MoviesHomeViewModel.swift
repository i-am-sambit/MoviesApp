//
//  MoviesHomeViewModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 26/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Categories: Identifiable {
    let id: Int
    let name: String
    let movies: [MovieBaseProtocol]
}

class MoviesHomeViewModel: ObservableObject {
    let objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    
    var shouldShowActivityIndicator: Bool {
        return movieCategories.count < 4
    }
    
    var movieCategories: [Categories] = [] {
        didSet {
            if !shouldShowActivityIndicator {
                self.movieCategories.sort { $0.id < $1.id }
                self.objectWillChange.send()
            }
        }
    }
    
    var tvCategories: [Categories] = [] {
        didSet {
            if !shouldShowActivityIndicator {
                self.tvCategories.sort { $0.id < $1.id }
                self.objectWillChange.send()
            }
        }
    }
    
    init() {
        fetchPopularMovies()
        fetchNowPlayingMovies()
        fetchUpcomingMovies()
        fetchTopRatedMovies()
        
        fetchTvOnTheAir()
        fetchTvTodaysAiring()
        fetchTvPopular()
        fetchTvTopRated()
    }
    
    private func fetchPopularMovies() {
        WebServiceHandler().fetchPopularMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    let popularMovies = response.results
                    self.movieCategories.append(Categories(id: 1, name: "Popular", movies: popularMovies))
                    break
                case .failure(let error):
                    print("Unable to fetch movies : \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    private func fetchNowPlayingMovies() {
        WebServiceHandler().fetchNowPlayingMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    let nowPlayingMovies = response.results
                    self.movieCategories.append(Categories(id: 0, name: "Now Playing", movies: nowPlayingMovies))
                    break
                case .failure(let error):
                    print("Unable to fetch movies : \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    private func fetchUpcomingMovies() {
        WebServiceHandler().fetchUpcomingMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    let upcomingMovies = response.results
                    self.movieCategories.append(Categories(id: 2, name: "Upcoming", movies: upcomingMovies))
                    break
                case .failure(let error):
                    print("Unable to fetch movies : \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    private func fetchTopRatedMovies() {
        WebServiceHandler().fetchTopRatedMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    let topRatedMovies = response.results
                    self.movieCategories.append(Categories(id: 3, name: "Top Rated", movies: topRatedMovies))
                    break
                case .failure(let error):
                    print("Unable to fetch movies : \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    private func fetchTvTodaysAiring() {
        WebServiceHandler().fetchTvTodaysAiring { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    let tvAiringToday = response.results
                    self.tvCategories.append(Categories(id: 0, name: "Airing Today", movies: tvAiringToday))
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    private func fetchTvOnTheAir() {
        WebServiceHandler().fetchTvOnTheAir { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    let tvOnAir = response.results
                    self.tvCategories.append(Categories(id: 1, name: "On Air", movies: tvOnAir))
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    private func fetchTvPopular() {
        WebServiceHandler().fetchTvPopular { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    let tvPopular = response.results
                    self.tvCategories.append(Categories(id: 2, name: "Popular", movies: tvPopular))
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    private func fetchTvTopRated() {
        WebServiceHandler().fetchTvTopRated { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    let tvTopRated = response.results
                    self.tvCategories.append(Categories(id: 3, name: "Top Rated", movies: tvTopRated))
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
}
