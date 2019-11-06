//
//  HeaderIView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 02/11/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @Binding var showHambergerMenu: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    self.showHambergerMenu = !self.showHambergerMenu
                }
                
            }) {
                Image(systemName: "text.justify")
                    .imageScale(.large)
                    .accessibility(label: Text("Hamberger Menu"))
                    .padding()
                    .foregroundColor(.primary)
            }
            
            Text("Movies App")
                .font(.largeTitle)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(.vertical)
    }
}

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//    }
//}
