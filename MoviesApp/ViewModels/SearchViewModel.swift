//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 21/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import UIKit
import Combine

class SearchViewModel: BaseViewModel {
    private(set) var movies: [MovieBaseProtocol] = []
    
    private var searchSubscriber: AnyCancellable?
    
    
    func search(movie: String) {
        do {
            searchSubscriber = try WebServiceHandler()
                .search(movie: movie, page: 1)
                .receive(on: RunLoop.main).sink(receiveCompletion: { (completionHandler) in
                    self.parse(completionHandler: completionHandler)
                }) { (response) in
                    self.movies = response.results
                    self.objectWillChange.send()
            }
        } catch let error {
            self.error = error
        }
        
    }
}
