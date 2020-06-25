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
    private var url: URL
    @ObservedObject private var imageLoader: ImageLoader
    
    init(urlString: String, placeHolder: Image = Image("avengers")) {
        self.urlString = urlString
        self.placeHolderImage = placeHolder
        self.imageLoader = ImageLoader()
        
        url = try! URLBuilder()
            .set(poster: urlString)
            .buildImageURL()
        
    }
    
    var body: some View {
        VStack {
            if !url.absoluteString.isEmpty && !urlString.isEmpty {
                AsyncImageView(url: url)
            } else {
                placeHolderImage
                    .renderingMode(.original)
                    .resizable()
                    .foregroundColor(.primary)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: "/4q2NNj4S5dG2RLF9CpXsej7yXl.jpg", placeHolder: Image("avengers"))
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func loadImageData(urlString: String) {
        WebServiceHandler().setImage(urlString: urlString) { (result) in
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
