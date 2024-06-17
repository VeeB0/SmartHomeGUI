//
//  ContentView.swift
//  Desivo
//
//  Created by Иван Дмитриев on 03.05.2024.
//

import SwiftUI

struct ContentView: View {
    var alerts = "99+"
    
    var body: some View {
        TabView {
            ReceivedView()
                .tabItem {
                    Label("Главная", systemImage: "house")
                }
            AccountView()
                .badge(alerts)
                .tabItem {
                    Label("Профиль", systemImage: "person.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
    
}
