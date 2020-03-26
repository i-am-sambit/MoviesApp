//
//  ImageView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 26/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI
import Combine

struct URLImageView: View {
    var urlString: String
    var placeHolderImage: Image
    
    @ObservedObject private var imageLoader: ImageLoader
    
    init(urlString: String, placeHolder: Image = Image("avengers")) {
        self.urlString = urlString
        self.placeHolderImage = placeHolder
        self.imageLoader = ImageLoader()
    }
    
    var body: some View {
        if let uiImage = imageLoader.image {
            let image = Image(uiImage: uiImage)
            return image
                .renderingMode(.original)
                .resizable()
                .onAppear()
        } else {
            return placeHolderImage
                .renderingMode(.original)
                .resizable()
                .onAppear {
                    self.imageLoader.loadImageData(urlString: self.urlString)
                }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: "", placeHolder: Image("avengers"))
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func loadImageData(urlString: String) {
        WebServiceHandler.shared.setImage(urlString: urlString) { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data):
                    self.image = UIImage(data: data)
                case .failure(_):
                    break
                }
            }
        }
    }
}
