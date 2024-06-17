//
//  NotificationView.swift
//  Desivo
//
//  Created by Иван Дмитриев on 07.05.2024.
//

import SwiftUI

struct Notification: Identifiable {
    var id = UUID()
    var text: String
    var time: Date
}

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var notifications = [
        Notification(text: "Умный термостат достиг заданной температуры", time: Date()),
        Notification(text: "Умная стиральная машина завершила цикл стирки", time: Date()),
        Notification(text: "Умная сигнализация активирована", time: Date()),
        Notification(text: "Умный холодильник сообщает о низком уровне молока", time: Date()),
        Notification(text: "Умные жалюзи закрыты на ночь", time: Date()),
        Notification(text: "Умные жалюзи закрыты на ночь", time: Date()),
        Notification(text: "Умные жалюзи открыты на день", time: Date()),
        Notification(text: "Умные ворота открыты", time: Date())
    ]
    
    var body: some View {
        VStack {
            HStack () {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                HStack {
                    Image(systemName: "chevron.left")
                            
                    Text("Назад")
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                Text("Уведомления")
                    .font(.title)
                    .bold()
                Spacer()
            }
            
            Spacer()
            
            List {
                ForEach(notifications) { notification in
                    VStack(alignment: .leading) {
                        Text(notification.text)
                        Text(notification.time, style: .time)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .padding([.top], 15)
        
        Button(action: {
            notifications.removeAll()
            }) {
                Text("Прочитать все")
            }
            .frame(width: 150, height: 20)
    }
    
    func delete(at offsets: IndexSet) {
        notifications.remove(atOffsets: offsets)
    }
}

#Preview {
    NotificationsView()
}
