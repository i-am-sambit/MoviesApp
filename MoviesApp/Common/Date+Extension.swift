//
//  Date+Extension.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 23/03/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation

extension Date {
    func convertToString()-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let dateString = formatter.string(from: self)
        return dateString
    }
}
