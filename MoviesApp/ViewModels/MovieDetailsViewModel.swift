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
    
    private(set) var movie: Movie
    private(set) var videos: [MovieVideo] = []
    
    init(movie: Movie) {
        self.movie = movie
      self.fetchVideos(forMovie: movie.id)
    }
    
    private func fetchVideos(forMovie movieID: Int) {
        WebServiceHandler().fetchTrailerVideos(movie: movieID) { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    self.videos = response.results
                    self.objectWillChange.send()
                    
                case .failure(_):
                    break
                }
            }
        }
    }
}
