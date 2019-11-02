//
//  HeaderIView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 02/11/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: "text.justify")
                    .imageScale(.large)
                    .accessibility(label: Text("Hamberger Menu"))
                    .padding()
                    .foregroundColor(.primary)
            }
            
            Text("Movies App")
                .font(.title)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(.bottom)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
