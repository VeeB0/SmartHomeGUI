import SwiftUI
import UserNotifications

struct NotificationSettingsView: View {
  @Environment(\.presentationMode) var presentationMode
  @State private var notificationsEnabled: Bool = false

  var body: some View {
    Form {
      Section {
        Toggle("Включить уведомления", isOn: $notificationsEnabled)
          .onChange(of: notificationsEnabled) { value in
            if value {
              requestNotificationAuthorization()
            }
          }
        Button("Тестовое уведомление") {
          sendLocalNotification()
        }
      }
    }
    .navigationTitle("Уведомления")
  }

  private func requestNotificationAuthorization() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      if granted {
        print("Права на уведомления выданы")
      } else {
        print("Права на уведомления не выданы")
      }
    }
  }

  private func sendLocalNotification() {
    let center = UNUserNotificationCenter.current()

    let content = UNMutableNotificationContent()
    content.title = "Тестовое уведомление"
    content.body = "Это тестовое уведомление."

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // Adjust delay

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    center.add(request) { error in
      if let error = error {
        print("Ошибка отправки уведомления: \(error.localizedDescription)")
      } else {
        print("Уведомление отправленно успешно")
      }
    }
  }
}

struct NotificationSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    NotificationSettingsView()
  }
}
