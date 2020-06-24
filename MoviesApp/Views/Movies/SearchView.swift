//
//  SearchView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 03/05/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            if !viewModel.movies.isEmpty {
                ScrollView {
                    ForEach(viewModel.movies, id: \.id) { movie in
                        SearchMovieCardView(movie: movie)
                    }
                }.padding(.horizontal, 15)
                    .padding(.top, 44)
            } else if viewModel.error != nil {
                EmptyView()
            } else {
                LoaderView(isAnimating: true)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.viewModel.search(movie: "Avengers")
        }
        .alert(isPresented: Binding<Bool>(
            get: { (self.viewModel.error != nil) },
            set: { _ in }
        )) {
            Alert(
                title: Text("Error!"),
                message: Text(self.viewModel.error?.localizedDescription ?? "")
            )
        }
    }
}

struct SearchIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environment(\.colorScheme, .dark)
    }
}
