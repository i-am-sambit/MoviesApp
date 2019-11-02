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

class MoviesHomeViewModel: ObservableObject {
    let objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
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
                    self.popularMovies = response.results
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
                    self.nowPlayingMovies = response.results
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
                    self.upcomingMovies = response.results
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
                    self.topRatedMovies = response.results
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
