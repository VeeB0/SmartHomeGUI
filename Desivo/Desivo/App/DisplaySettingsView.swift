import SwiftUI

enum Theme: String, CaseIterable, Codable {
    case light, dark, system

    var description: String {
        switch self {
        case .light: return "Светлая тема"
        case .dark: return "Темная тема"
        case .system: return "Системная тема"
        }
    }
}

struct DisplaySettingsView: View {
    @AppStorage("selectedTheme") private var selectedTheme: Theme = .system

    var body: some View {
        Form {
            Section {
                Picker("Тема", selection: $selectedTheme) {
                    ForEach(Theme.allCases, id: \.self) { theme in
                        Text(theme.description).tag(theme)
                    }
                }
            }
        }
        .navigationTitle("Отображение")
        .onChange(of: selectedTheme) { newValue in
            setTheme(newValue)
        }
    }
    
    func setTheme(_ theme: Theme) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.first?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
}

struct DisplaySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DisplaySettingsView()
    }
}

extension Theme {
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return .unspecified
        }
    }
}
