//
//  MovieVideoViewModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 28/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine

class MovieDetailsViewModel: BaseViewModel {
    private var movieId: Int
    
    private var videos: [MovieVideo] = []
    private(set) var movie: MovieDetailsResponseModel?
    private(set) var casts: [MovieCastModel] = []
    private(set) var similarMovies: [Movie] = []
    
    private var detailsSubscription: AnyCancellable?
    private var creditsSubscription: AnyCancellable?
    private var similarMoviesSubscription: AnyCancellable?
    
    init(movie id: Int) {
        self.movieId = id
    }
    
    func fetchDetails() {
        do {
            detailsSubscription = try WebServiceHandler().fetchDetails(movie: movieId)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completionHandler) in
                    self.parse(completionHandler: completionHandler)
                }, receiveValue: { (response) in
                    self.movie = response
                    self.sendLiveData()
                })
        } catch let error {
            self.error = error
        }
        
    }
    
    func fetchCredits() {
        do {
            creditsSubscription = try WebServiceHandler().fetchCredits(movie: movieId)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completionHandler) in
                    self.parse(completionHandler: completionHandler)
                }, receiveValue: { (response) in
                    self.casts = response.cast
                    self.sendLiveData()
                })
        } catch let error {
            self.error = error
        }
    }
    
    func fetchSimilarMovies() {
        do {
            similarMoviesSubscription = try WebServiceHandler().fetchSimilar(movies: movieId)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completionHandler) in
                    self.parse(completionHandler: completionHandler)
                }, receiveValue: { (response) in
                    self.similarMovies = response.results
                    self.sendLiveData()
                })
        } catch let error {
            self.error = error
        }
    }
    
    private func sendLiveData() {
        if movie != nil, !casts.isEmpty, !similarMovies.isEmpty {
            self.objectWillChange.send()
        }
    }
}
