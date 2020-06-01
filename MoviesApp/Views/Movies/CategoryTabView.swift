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
                }.tag(CategoryTag.home)
                .navigationBarTitle(CategoryTitle.home.rawValue)
                .navigationBarHidden(true)
                
                SearchView()
                .tabItem {
                        Text(CategoryTitle.search.rawValue)
                        Image(systemName: "magnifyingglass")
                }.tag(CategoryTag.search)
                .navigationBarTitle(CategoryTitle.search.rawValue)
                .navigationBarHidden(true)
                
                MovieHomeView()
                    .tabItem {
                        Text(CategoryTitle.upcoming.rawValue)
                        Image(systemName: selectedTab == CategoryTag.upcoming.rawValue ? "film.fill" : "film")
                    }.tag(CategoryTag.upcoming)
                .navigationBarTitle(CategoryTitle.upcoming.rawValue)
                .navigationBarHidden(true)
                
                ProfileView()
                    .tabItem {
                        Text(CategoryTitle.profile.rawValue)
                        Image(systemName: selectedTab == CategoryTag.profile.rawValue ? "person.fill" : "person")
                    }.tag(CategoryTag.profile)
                .navigationBarTitle(CategoryTitle.profile.rawValue)
                .navigationBarHidden(true)
            }
            .accentColor(.yellow)
        }
    }
}

extension CategoryTabView {
    private enum CategoryTag: Int {
        case home
        case search
        case upcoming
        case profile
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
        CategoryTabView()
    }
}
