//
//  RoomView.swift
//  Desivo
//
//  Created by Иван Дмитриев on 10.05.2024.
//

import SwiftUI

struct RoomView: View {
    var room: Room
    @State private var isRoomOn: Bool = true

    var body: some View {
        NavigationLink(destination: DetailRoomView(room: room)) {
            VStack {
                HStack {
                    Spacer()
                    Text("\(room.temperature)°")
                        .foregroundColor(.white)
                        .bold()
                    Image(systemName: "thermometer.medium")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 25, maxHeight: 35)
                        .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 15))
                        .foregroundColor(.white)
                }
                HStack {
                    Image(systemName: room.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 60, maxHeight: 40, alignment: .leading)
                        .foregroundColor(.white)
                        .padding([.leading], 20)
                    Spacer()
                }
                Text(room.name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                Text("\(room.devices) устройств")
                    .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
            }
            .frame(width: 170, height: 170)
            .background(
                Group {
                    if isRoomOn {
                        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.pink, Color.purple]), startPoint: .top, endPoint: .bottom)
                    } else {
                        Color.gray
                    }
                }
            )
            .cornerRadius(25)
            .animation(.easeInOut(duration: 0.4), value: isRoomOn)
            .contextMenu(ContextMenu(menuItems: {
                Button(action: {
                    withAnimation {
                        isRoomOn.toggle()
                    }
                    print(isRoomOn ? "Комната включена" : "Комната выключена")
                }) {
                    Image(systemName: isRoomOn ? "minus" : "plus")
                    Text(isRoomOn ? "Выключить комнату" : "Включить комнату")
                }
                Button(action: {
                    print("Кнопка нажата")
                }) {
                    Text("Изменить комнату")
                }
                Button(action: {
                    print("Кнопка нажата")
                }) {
                    Text("Удалить комнату")
                }
            }
            ))
            .padding(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
