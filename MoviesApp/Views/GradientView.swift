//
//  GradientView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 15/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct GradientView: View {
    var movieName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(movieName)
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
