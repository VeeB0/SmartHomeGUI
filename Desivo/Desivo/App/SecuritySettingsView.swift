//
//  SecuritySettingsView.swift
//  Desivo
//
//  Created by Иван Дмитриев on 06.06.2024.
//

import SwiftUI

struct SecuritySettingsView: View {
    @State private var password: String = ""
    @State private var newPassword: String = ""
    @State private var newPasswordAgain: String = ""
    @State private var email: String = ""
    @State private var nickname: String = ""

    var body: some View {
        Form {
            Section(header: Text("Смена пароля")) {
                SecureField("Старый пароль", text: $password)
                SecureField("Новый пароль", text: $password)
                SecureField("Повторить новый пароль", text: $password)
            }

            Section(header: Text("Смена почты")) {
                TextField("Новая почта", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }

            Section(header: Text("Смена никнейма")) {
                TextField("Новый никнейм", text: $nickname)
            }
        }
        .navigationTitle("Безопасность")
    }
}


#Preview {
    SecuritySettingsView()
}
