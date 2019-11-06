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
    var movieCategories: [Categories] = []
    var tvCategories: [Categories] = []
    
    private(set) var popularMovies: [Movie] = []
    private(set) var nowPlayingMovies: [Movie] = []
    private(set) var upcomingMovies: [Movie] = []
    private(set) var topRatedMovies: [Movie] = []
    
    private(set) var tvAiringToday: [TVAiring] = []
    private(set) var tvOnAir: [TVAiring] = []
    private(set) var tvPopular: [TVAiring] = []
    private(set) var tvTopRated: [TVAiring] = []
    
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
                    self.movieCategories.append(Categories(id: 0, name: "Popular", movies: popularMovies))
                    self.objectWillChange.send()
                    break
                case .failure(_):
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
                    self.movieCategories.append(Categories(id: 1, name: "Now Playing", movies: nowPlayingMovies))
                    
                    self.objectWillChange.send()
                    break
                case .failure(_):
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
                    self.objectWillChange.send()
                    break
                case .failure(_):
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
                    self.objectWillChange.send()
                    break
                case .failure(_):
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
                    self.tvAiringToday = response.results
                    self.objectWillChange.send()
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
                    self.tvOnAir = response.results
                    self.objectWillChange.send()
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
                    self.tvPopular = response.results
                    self.objectWillChange.send()
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
                    self.tvTopRated = response.results
                    self.objectWillChange.send()
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
}
