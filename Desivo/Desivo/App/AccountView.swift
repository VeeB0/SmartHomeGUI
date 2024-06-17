//
//  AccountView.swift
//  Desivo
//
//  Created by Иван Дмитриев on 03.05.2024.
//

import SwiftUI

struct User {
    var username: String
    var email: String
}

struct AccountView: View {
    @State private var username: String = "VeeBo"
    @State private var email: String = "veebo.mail@gmail.com"
    @State private var avatar: Image = Image("Avatar")
    @State private var showNotifications: Bool = false
    @State private var showSettings: Bool = false

        var body: some View {
            NavigationView {
                VStack {
                    HStack {
                        Text("Профиль")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                        
                        Button(action: {
                            print("Редактировать")
                        }) {
                            Image(systemName: "square.and.pencil.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35, maxHeight: 35)
                        }
                        
                        Button(action: {
                            showNotifications = true
                        }) {
                            Image(systemName: "bell.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35, maxHeight: 35)
                                .padding(.trailing)
                        }
                    }
                    .padding([.bottom], 50)
                    
                    VStack {
                        HStack {
                            Spacer()
                            VStack {
                                avatar
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                                    .shadow(color: .blue, radius: 15)
                            }
                            Spacer()
                        }
                        Text(username)
                            .padding([.bottom], -5)
                            .bold()
                            .font(.title)
                        Text(email)
                            .foregroundColor(.gray)
                            .padding(1)
                    }
                    .padding()
                    
                    Button(action: {
                        showSettings = true
                    }) {
                        Text("Настройки")
                    }.padding(10)
                    
                    Button(action: {
                        print("Выход")
                        exit(0)
                    }) {
                        Text("Выход")
                    }.padding(10)
                    
                    Text("Версия 0.0.1")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding([.top], 50)
                    Spacer()
                }.sheet(isPresented: $showNotifications) {
                    NotificationsView()
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }
            }
        }
}

#Preview {
    AccountView()
}
