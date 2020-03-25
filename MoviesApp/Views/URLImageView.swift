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
    var image: UIImage?
    var objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    
    func loadImageData(urlString: String) {
        WebServiceHandler.shared.setImage(urlString: urlString) { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data):
                    self.image = UIImage(data: data)
                    self.objectWillChange.send()
                case .failure(_):
                    break
                }
            }
        }
        if let url: URL = URL(string: "https://image.tmdb.org/t/p/w300_and_h300_bestv2\(urlString)") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                DispatchQueue.main.async {
                    guard let data = data, data.count > 0 else {
                        return
                    }
                    
                    self.image = UIImage(data: data)
                    self.objectWillChange.send()
                }
                
            }.resume()
        }
    }
}
