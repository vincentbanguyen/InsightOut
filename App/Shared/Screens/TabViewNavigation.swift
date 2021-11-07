//
//  TabView.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI

struct TabViewNavigation: View {
    @State private var backgroundColor = Color("happiness")
    var body: some View {
        TabView {
            HomeView(backgroundColor: $backgroundColor)
                .tabItem {
                    Label("Home", systemImage: "house")
                        .foregroundColor(.black)
                }
            OverviewView()
                .tabItem {
                    Label("Overview", systemImage: "calendar")
                        .foregroundColor(.black)
                }
        }
        .accentColor(backgroundColor)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewNavigation()
    }
}
