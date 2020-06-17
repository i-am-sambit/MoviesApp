//
//  BaseViewModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 17/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    let objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    var error: Error? {
        didSet {
            if error != nil {
                self.objectWillChange.send()
            }
        }
    }
    
    func parse(completionHandler: Subscribers.Completion<Error>) {
        switch completionHandler {
            
        case .finished:
            break
        case .failure(let error):
            self.error = error
        }
    }
}
