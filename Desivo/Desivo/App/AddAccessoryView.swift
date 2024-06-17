import SwiftUI

struct GradientSnakeView: View {
    @State private var gradientStart: CGFloat = -0.5
    @State private var gradientEnd: CGFloat = 0.5

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .strokeBorder(lineWidth: 3)
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), startPoint: UnitPoint(x: gradientStart, y: 0.1), endPoint: UnitPoint(x: gradientEnd, y: 0.1))
                    .mask(RoundedRectangle(cornerRadius: 20).strokeBorder(lineWidth: 3))
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 12).repeatForever(autoreverses: true)) {
                    self.gradientStart = 1
                    self.gradientEnd = 1.5
                }
            }
    }
}


struct AddAccessoryView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Добавить аксессуар")
                .font(.largeTitle)
                .bold()
                .padding()
                .multilineTextAlignment(.center)

            Text("Отсканируйте код или поднесите iPhone ближе к этому аксессуару.")
                .padding()
            
            QRCodeScannerView { code in
                print("Scanned QR Code: \(code)")
                // Обработка отсканированного кода
                presentationMode.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity, maxHeight: 350)
            .cornerRadius(20)
            .overlay(GradientSnakeView())
            .padding([.leading, .trailing])
            
            Spacer()
        }
        .navigationBarTitle("Добавить аксессуар", displayMode: .inline)
        .navigationBarItems(trailing: Button("Отмена") {
            presentationMode.wrappedValue.dismiss()
        })
    }
}

#Preview {
    AddAccessoryView()
}
