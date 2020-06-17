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
    
    private let imageHeight: CGFloat = UIScreen.main.bounds.size.width
    private let collapsedImageHeight: CGFloat = 75
    
    init(cast: MovieCastModel) {
        viewModel = ActorProfileViewModel(cast: cast)
    }
    
    var body: some View {
        VStack {
            if viewModel.castDetails != nil {
                List {
                    VStack(alignment: .leading) {
                        
                        VStack {
                            GeometryReader { geometry in
                                URLImageView(urlString: self.viewModel.castDetails!.person.profilePath)
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
                                    .blur(radius: self.getBlurRadiusForImage(geometry))
                                    .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
                            }.frame(height: UIScreen.main.bounds.size.width)
                            
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.castDetails!.person.name)
                                    .font(.title)
                                    .padding()
                                
                                Text(viewModel.castDetails!.job)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: true) {
                                    HStack {
                                        ForEach(viewModel.castDetails!.person.knownFor, id:\.id) { movie in
                                            NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                                MovieCardView(movie: movie)
                                            }
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
                        .padding(-20)
                        
                    }
                }
            } else {
                LoaderView(isAnimating: true)
            }
        }
        .background(Color.backgroundColor)
        .edgesIgnoringSafeArea(.vertical)
        .onAppear {
            self.viewModel.fetchCreditDetails()
        }
    }
}

extension ActorProfileView {
    func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = imageHeight - collapsedImageHeight

        if offset < -sizeOffScreen {
            let imageOffset = abs(min(-sizeOffScreen, offset))
            return imageOffset - sizeOffScreen
        }
        
        if offset > 0 {
            return -offset
        }
        
        return 0
    }
    
    func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height

        if offset > 0 {
            return imageHeight + offset
        }

        return imageHeight
    }
    
    func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY

        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height
        return blur * 6
    }
}

struct ActorProfileView_Previews: PreviewProvider {
    static let cast: MovieCastModel = MovieCastModel(castId: 379, character: "Peter Parker / Spider-Man", creditId: "5d3ef9e934e1525dace8b35c", gender: 2, id: 1136406, name: "Tom Holland", order: 0, posterPath: "")
    
    static var previews: some View {
        Group {
            ActorProfileView(cast: cast)
                .previewDevice(.init(rawValue: "iPhone 8 Plus"))
                .environment(\.colorScheme, .dark)
            
//            ActorProfileView(cast: cast)
//                .environment(\.colorScheme, .light)
//
//            ActorProfileView(cast: cast)
//                .previewDevice(.init(rawValue: "iPad Pro (9.7-inch)"))
//                .environment(\.colorScheme, .light)
        }
    }
}
