//
//  MovieVideoViewModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 28/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine

class MovieDetailsViewModel: ObservableObject {
    let objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    
    public var movieId: Int = 0
    
    private(set) var videos: [MovieVideo] = []
    private(set) var movie: MovieDetailsResponseModel?
    private(set) var casts: [MovieCastModel] = []
    
    private var detailsSubscription: AnyCancellable?
    private var creditsSubscription: AnyCancellable?
    
    func fetchDetails() {
        do {
            detailsSubscription = try WebServiceHandler().fetchDetails(movie: movieId)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completionHandler) in
                    print(completionHandler)
                }, receiveValue: { (response) in
                    self.movie = response
                    self.objectWillChange.send()
                })
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func fetchCredits() {
        do {
            creditsSubscription = try WebServiceHandler().fetchCredits(movie: movieId)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completionHandler) in
                    print(completionHandler)
                }, receiveValue: { (response) in
                    self.casts = response.cast
                    self.objectWillChange.send()
                })
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
