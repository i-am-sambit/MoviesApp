//
//  TheaterViewModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 23/03/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine

struct DateDataSource: Hashable {
    let id: Int
    let day: String
    let month: String
}

class TheatreViewModel: ObservableObject {
//    let objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    
    @Published var selectedSeats: [Int] = []
    @Published var reservedSeats: [Int] = []
}
