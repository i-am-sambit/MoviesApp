//
//  AsyncImageView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 24/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct AsyncImageView: View {
    private var url: URL
    private var placeHolder: Image?
    private var showLoadingIndicator: Bool = false
    
    @ObservedObject var binder = AsyncImageBinder()
    
    init(url: URL, placeHolder: Image? = nil) {
        self.url = url
        self.placeHolder = placeHolder
        self.binder.load(url: self.url)
    }
    
    init?(url: String, placeHolder: Image? = nil) {
        guard let url = URL(string: url) else { return nil }
        self.init(url: url, placeHolder: placeHolder)
    }
    
    var body: some View {
        VStack {
            if binder.image != nil {
                Image(uiImage: binder.image!)
                    .renderingMode(.original)
                    .resizable()
            } else {
                placeHolder
            }
        }
        .onAppear {  }
        .onDisappear { self.binder.cancel() }
    }
}



struct AsyncImageView_Previews: PreviewProvider {
    static let url = URL(string: "https://image.tmdb.org/t/p/original/cDbOrc2RtIA37nLm0CzVpFLrdaG.jpg")!
    
    
    static var previews: some View {
        AsyncImageView(url: url)
            .preview(device: .iPhone11ProMax, displayMode: .dark)
    }
}
