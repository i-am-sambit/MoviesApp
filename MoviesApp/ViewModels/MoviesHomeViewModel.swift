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
    var movieCategories: [Categories] = [] {
        didSet {
            self.movieCategories.sort { (first, second) -> Bool in
                first.id < second.id
            }
        }
    }
    var tvCategories: [Categories] = [] {
           didSet {
               self.tvCategories.sort { (first, second) -> Bool in
                   first.id < second.id
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
                    let tvAiringToday = response.results
                    self.tvCategories.append(Categories(id: 0, name: "Airing Today", movies: tvAiringToday))
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
                    let tvOnAir = response.results
                    self.tvCategories.append(Categories(id: 1, name: "On Air", movies: tvOnAir))
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
                    let tvPopular = response.results
                    self.tvCategories.append(Categories(id: 2, name: "Popular", movies: tvPopular))
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
                    let tvTopRated = response.results
                    self.tvCategories.append(Categories(id: 3, name: "Top Rated", movies: tvTopRated))
                    self.objectWillChange.send()
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
}
