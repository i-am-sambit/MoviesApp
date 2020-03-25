//
//  MovieUIView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct MovieDetailsView: View {
    var movie: MovieBaseProtocol
    
    @State var moveToTrailer: Bool = false
    @State var willBookTicket: Bool = false
    
    var generDataSource = ["Action", "Adventure", "Sci-fi"]
    
    init(movie: MovieBaseProtocol) {
        self.movie = movie
    }
    
    var body: some View {
        NavigationLink(destination: TheaterView(), isActive: $willBookTicket) {
            GeometryReader { geometryReader in
                VStack {
                    ScrollView {
                        URLImageView(urlString: self.movie.poster)
                            .frame(minWidth: 250, maxWidth: .infinity, maxHeight: 400)
                        
                        HStack {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color.gray.opacity(0.5))
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: (geometryReader.size.width - 80) * (3.9/5))
                                    .foregroundColor(.blue)
                            }
                            .frame(width: geometryReader.size.width - 80, height: 10)
                            Text("3.9/5").font(.headline)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.generDataSource, id: \.self) { gener in
                                    GenerView(gener: gener)
                                }
                            }
                        }.padding(.horizontal)
                        
                        Text(self.movie.overview)
                            .font(.system(size: 17))
                            .foregroundColor(.primary)
                            .padding()
                    }
                    
                    Button(action: {
                        self.willBookTicket = true
                    }) {
                        Text("BOOK TICKET")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .frame(minWidth: 400, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color.red)
                }
            }
            .navigationBarTitle(movie.name)
        }
    }
}

struct GenerView: View {
    var gener: String
    
    var body: some View {
        Text(gener)
            .font(.headline)
            .foregroundColor(.gray)
    }
}

struct MovieUIView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie(id: 0, name: "Avengers EndGame", overview: "Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame Avengers EndGame  Avengers EndGame", poster: "", releaseDate: ""))
    }
}
