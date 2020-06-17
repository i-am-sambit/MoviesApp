//
//  ActorProfileViewModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 16/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine

class ActorProfileViewModel: BaseViewModel {
    private var cast: MovieCastModel
    private(set) var castDetails: MovieCastDetailsResponseModel?
    
    var castDetailsSubscriber: AnyCancellable?
    
    init(cast: MovieCastModel) {
        self.cast = cast
    }
    
    func fetchCreditDetails() {
        do {
            castDetailsSubscriber = try WebServiceHandler().fetchCreditDetails(creditId: cast.creditId)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completionHandler in
                    self.parse(completionHandler: completionHandler)
                }) { (response) in
                    self.castDetails = response
                    self.objectWillChange.send()
            }
        } catch let error {
            self.error = error
        }
        
    }
}
