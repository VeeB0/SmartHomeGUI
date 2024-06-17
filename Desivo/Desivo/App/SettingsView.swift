//
//  SwiftUIView.swift
//  Desivo
//
//  Created by Иван Дмитриев on 05.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SecuritySettingsView()) {
                    Text("Безопасность")
                }
                
                NavigationLink(destination: NotificationSettingsView()) {
                    Text("Уведомления")
                }
                
                NavigationLink(destination: DisplaySettingsView()) {
                    Text("Отображение")
                }
            }
            .navigationTitle("Настройки")
            .padding([.top], 0)
        }
    }
}

#Preview {
    SettingsView()
}
