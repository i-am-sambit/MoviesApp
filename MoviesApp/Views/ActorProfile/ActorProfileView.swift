//
//  ActorProfileView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 16/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct ActorProfileView: View {
    @ObservedObject var viewModel: ActorProfileViewModel
    
    init(cast: MovieCastModel) {
        viewModel = ActorProfileViewModel(cast: cast)
    }
    
    var body: some View {
        ScrollView {
            if viewModel.castDetails != nil {
                VStack {
                    URLImageView(urlString: viewModel.castDetails!.person.profilePath)
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.castDetails!.person.name)
                            .font(.title)
                            .padding()
                        
                        Text(viewModel.castDetails!.job)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
    //                    Text(cast.biography)
    //                        .lineLimit(4)
    //                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                                ForEach(viewModel.castDetails!.person.knownFor, id:\.id) { movie in
                                    MovieCardView(movie: movie)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(Color.backgroundColor)
                    .cornerRadius(radius: 40, corners: [.topLeft, .topRight])
                    .padding(.top, -50)
                }
            } else {
                EmptyView()
            }
        }
        .background(Color.backgroundColor)
        .edgesIgnoringSafeArea(.vertical)
        .onAppear {
            self.viewModel.fetchCreditDetails()
        }
    }
}

struct ActorProfileView_Previews: PreviewProvider {
    static let cast: MovieCastModel = MovieCastModel(castId: 379, character: "Peter Parker / Spider-Man", creditId: "5d3ef9e934e1525dace8b35c", gender: 2, id: 1136406, name: "Tom Holland", order: 0, posterPath: "")
    
    static var previews: some View {
        Group {
            ActorProfileView(cast: cast)
                .environment(\.colorScheme, .dark)
            
            ActorProfileView(cast: cast)
                .environment(\.colorScheme, .light)
            
            ActorProfileView(cast: cast)
                .previewDevice(.init(rawValue: "iPad Pro (9.7-inch)"))
                .environment(\.colorScheme, .light)
        }
    }
}
