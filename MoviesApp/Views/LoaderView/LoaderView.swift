//
//  LoaderView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 17/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct LoaderView: View {
    @State var isAnimating: Bool
    
    var body: some View {
        VStack {
            ActivityIndicatorView(isAnimating: $isAnimating, style: .large)
                .foregroundColor(.primary)
            
            Text("Loading...")
                .font(.system(size: 25))
            
            Text("Please wait")
            .font(.system(size: 15))
        }
        .padding(50)
        .background(Color.secondaryBackgroundColor)
        .cornerRadius(20)
        .shadow(color: Color.shadowBackgroundColor, radius: 25)
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView(isAnimating: true)
    }
}
