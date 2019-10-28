//
//  MovieUIView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct MovieUIView: View {
    var movie: Movie
    
    var body: some View {
        NavigationView {
            VStack {
                URLImageView(urlString: movie.poster)
                    .frame(minWidth: 250, maxWidth: .infinity, maxHeight: 300)
                HStack(alignment: .top, spacing: 25) {
                    Button(action: {
                        print("Add to list")
                    }) {
                        Image(systemName: "list.bullet")
                            .imageScale(.medium)
                            .foregroundColor(.primary)
                            .padding([.top, .leading, .trailing])
                            
                        Text("Add to List")
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        print("favourite")
                    }) {
                        Image(systemName: "heart")
                            .imageScale(.medium)
                            .foregroundColor(.primary)
                            .padding([.top, .leading, .trailing])
                            
                        Text("Favourite")
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        print("watch list")
                    }) {
                        Image(systemName: "bookmark")
                            .imageScale(.medium)
                            .foregroundColor(.primary)
                            .padding([.top, .leading, .trailing])
                        
                        Text("Watch List")
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        print("trailer")
                        NavigationLink(destination: VideosView(videos: [])) {
                            Text("Trailer")
                        }
                        
                    }) {
                        Image(systemName: "video")
                            .imageScale(.medium)
                            .foregroundColor(.primary)
                            .padding([.top, .leading, .trailing])
                        
                        Text("Trailer")
                            .foregroundColor(.primary)
                    }.tag(4)
                }
                .frame(minWidth: 250, maxWidth: .infinity)
                .padding(.horizontal)
                
                Text(movie.overview)
                    .font(.body)
                    .padding(.top)
                    .padding(.horizontal, 16)
                
                Spacer()
            }
    //        .frame(minWidth: 250, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    //        .padding(.horizontal, -16)
            .navigationBarTitle(movie.name)
        }
    }
}

struct MovieUIView_Previews: PreviewProvider {
    static var previews: some View {
        MovieUIView(movie: Movie(movieID: 0, name: "Avengers EndGame", overview: "Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame  Avengers EndGame", poster: "", releaseDate: ""))
    }
}
