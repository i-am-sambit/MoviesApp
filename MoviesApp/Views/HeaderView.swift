//
//  HeaderIView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 02/11/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    private var paddingTop = (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20) + 10
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("MovieDB")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.top, paddingTop)
                .padding(.leading)
                .padding(.bottom, 10)
            
            Spacer()
        }
        .background(Color(red: 26/255, green: 57/255, blue: 85/255))
        .edgesIgnoringSafeArea(.top)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
