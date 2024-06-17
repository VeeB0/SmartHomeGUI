//
//  DetailRoomView.swift
//  Desivo
//
//  Created by Иван Дмитриев on 08.05.2024.
//

import SwiftUI

struct DetailRoomView: View {
    @State private var useLargeTitle = true
    @State private var progress: CGFloat = 0.59
    var room: Room

    init(room: Room) {
        self.room = room
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text(room.name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading)
                        .frame(alignment: .leading)
                    Text("У вас \(room.devices) девайсов")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .frame(alignment: .leading)
                }
                Spacer()
                ScrollView (.horizontal) {
                    HStack {
                        DeviceButton(deviceName: "Light", imageName: "lightbulb.min.fill")
                        DeviceButton(deviceName: "TV", imageName: "lightbulb.min.fill")
                        DeviceButton(deviceName: "Air", imageName: "lightbulb.min.fill")
                        DeviceButton(deviceName: "Roller blind", imageName: "lightbulb.min.fill")
                    }
                }
                
                        Spacer()
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 40)
                                .opacity(0.3)
                                .foregroundColor(Color.gray)
                            Circle()
                                .trim(from: 0.0, to: progress)
                                .stroke(style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                                .foregroundColor(Color.red)
                                .rotationEffect(Angle(degrees: 270.0))

                            Text(String(format: "%.0f %%", progress * 100))
                                .font(.title)
                                .bold()
                        }
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                        .padding()
                    }
        }
    }
}


struct DeviceButton: View {
    let deviceName: String
    let imageName: String

    var body: some View {
        Button(action: {}) {
            Image(imageName)
            Text(deviceName)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 20))
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }
}
