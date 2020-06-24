//
//  TabController.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 03/05/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import SwiftUI


struct CategoryTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                MovieHomeView()
                    .tabItem {
                        Text(CategoryTitle.home.rawValue)
                        Image(systemName: (selectedTab == CategoryTag.home.rawValue ? "house.fill" : "house"))
                }
                .tag(CategoryTag.home.rawValue)
                .navigationBarTitle(CategoryTitle.home.rawValue)
                .navigationBarHidden(true)
                
                SearchView()
                    .tabItem {
                        Text(CategoryTitle.search.rawValue)
                        Image(systemName: "magnifyingglass")
                }
                .tag(CategoryTag.search.rawValue)
                .navigationBarTitle(CategoryTitle.search.rawValue)
                .navigationBarHidden(true)
                
                MovieHomeView()
                    .tabItem {
                        Text(CategoryTitle.upcoming.rawValue)
                        Image(systemName: selectedTab == CategoryTag.upcoming.rawValue ? "film.fill" : "film")
                }
                .tag(CategoryTag.upcoming.rawValue)
                .navigationBarTitle(CategoryTitle.upcoming.rawValue)
                .navigationBarHidden(true)
                
                ProfileView().tabItem {
                    Text(CategoryTitle.profile.rawValue)
                    Image(systemName: selectedTab == CategoryTag.profile.rawValue ? "person.fill" : "person")
                }
                .tag(CategoryTag.profile.rawValue)
                .navigationBarTitle(CategoryTitle.profile.rawValue)
                .navigationBarHidden(true)
            }
            .accentColor(.yellow)
        }
    }
}

extension CategoryTabView {
    private enum CategoryTag: Int {
        case home = 0
        case search = 1
        case upcoming = 2
        case profile = 3
    }
    
    private enum CategoryTitle: String {
        case home = "Home"
        case search = "Search"
        case upcoming = "Upcoming"
        case profile = "Profile"
    }
}

struct TabController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryTabView()
                .preview(device: .iPhone11ProMax, displayMode: .light)
            
            CategoryTabView()
                .preview(device: .iPhone11ProMax, displayMode: .dark)
            
            CategoryTabView()
                .preview(device: .iPhone8Plus, displayMode: .dark)
        }
    }
}
