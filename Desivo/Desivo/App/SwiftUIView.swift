import SwiftUI

struct AccessoryView1: View {
    @State private var isOn: Bool = true
    @State private var targetTemperature: Double = 22.0
    @State private var hysteresis: Double = 0.5
    @State private var temperatureData: [Double] = [5.0, 3.0, -5.0, -10.0, -15.0, -5.0, 0.0, 5.0]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Название")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Toggle(isOn: $isOn) {
                    Text("Активность")
                }
                .padding(.bottom, 20)
                
                // Temperature Chart
                Text("Температура (°C)")
                
                HStack {
                    Text("Целевая температура:\n\(String(format: "%.1f", targetTemperature))°C")
                    Spacer()
                    Text("Гистерезис:\n±\(String(format: "%.1f", hysteresis))°C")
                }
                .padding(.bottom, 10)
                
                // Slider for Target Temperature
                Slider(value: $targetTemperature, in: 15...30, step: 0.1) {
                    Text("Целевая температура")
                }
                .padding(.bottom, 10)
                
                // Slider for Hysteresis
                Slider(value: $hysteresis, in: 0.1...5, step: 0.1) {
                    Text("Гистерезис")
                }
            }
            .padding()
        }
    }
}
#Preview {
    AccessoryView1()
}
