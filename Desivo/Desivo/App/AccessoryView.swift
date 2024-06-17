import SwiftUI

struct AccessoryView: View {
    @State private var isOn: Bool = true
    @State private var targetTemperature: Double = 22.0
    @State private var hysteresis: Double = 0.5
    @State private var temperatureData: [Double] = [5.0, 3.0, -5.0, -10.0, -15.0, -5.0, 0.0, 5.0]
    @State private var selectedTemperature: Double = 0.0
    
    var accessory: Accessory

    init(accessory: Accessory) {
        self.accessory = accessory
        _selectedTemperature = State(initialValue: temperatureData.last ?? 0.0)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Отопление")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Toggle(isOn: $isOn) {
                    Text("Активность")
                }
                
                Text("\(selectedTemperature.formatted(.number.precision(.fractionLength(1))))°C")
                    .bold()
                
                TemperatureChart(data: temperatureData, selectedTemperature: $selectedTemperature)
                    .frame(height: 300)
                    .padding(.bottom, 20)
                
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
        .padding(.top, -5)
    }
}

struct TemperatureChart: View {
    var data: [Double]
    @State private var selectedIndex: Int? = nil
    @State private var draggedIndex: Int? = nil
    @Binding var selectedTemperature: Double

    var body: some View {
        GeometryReader { geometry in
            let path = createPath(in: geometry.size)

            ZStack {
                GridLines()

                path
                    .stroke(Color.blue, lineWidth: 3)
                
                if let draggedIndex = draggedIndex, draggedIndex < data.count {
                    let xPosition = CGFloat(draggedIndex) * (geometry.size.width / CGFloat(data.count - 1))
                    let yPosition = geometry.size.height - CGFloat(data[draggedIndex] - (data.min() ?? 0)) * (geometry.size.height / CGFloat((data.max() ?? 1) - (data.min() ?? 0)))
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 15, height: 15)
                        .position(x: xPosition, y: yPosition)
                        .transition(.scale)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let index = Int((value.location.x / geometry.size.width) * CGFloat(data.count - 1))
                        if index >= 0 && index < data.count {
                            withAnimation {
                                draggedIndex = index
                                selectedTemperature = data[index]
                            }
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            if let index = draggedIndex {
                                selectedTemperature = data[index]
                            } else {
                                selectedTemperature = data.last ?? 0.0
                            }
                            draggedIndex = nil
                        }
                    }
            )
            .onAppear {
                selectedTemperature = data.last ?? 0.0
            }
        }
    }

    func createPath(in size: CGSize) -> Path {
        var path = Path()
        guard data.count > 1 else { return path }
        
        let maxValue = data.max() ?? 1
        let minValue = data.min() ?? 0
        let range = maxValue - minValue
        
        let widthStep = size.width / CGFloat(data.count - 1)
        let heightRatio = size.height / CGFloat(range)
        
        path.move(to: CGPoint(x: 0, y: size.height - CGFloat(data[0] - minValue) * heightRatio))
        
        for index in 1..<data.count {
            let x = CGFloat(index) * widthStep
            let y = size.height - CGFloat(data[index] - minValue) * heightRatio
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path
    }
}




struct GridLines: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let gridSize: CGFloat = 40.0
                
                // Вертикальные линии
                for i in stride(from: 0, to: width, by: gridSize) {
                    path.move(to: CGPoint(x: i, y: 0))
                    path.addLine(to: CGPoint(x: i, y: height))
                }
                
                // Горизонтальные линии
                for i in stride(from: 0, to: height, by: gridSize) {
                    path.move(to: CGPoint(x: 0, y: i))
                    path.addLine(to: CGPoint(x: width, y: i))
                }
            }
            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        }
    }
}

struct MainAccessoryView: View {
    var accessory: Accessory
    @State private var isAccessoryOn: Bool = true

    var body: some View {
        NavigationLink(destination: AccessoryView(accessory: accessory)) {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "bolt.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 25, maxHeight: 35)
                        .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 15))
                        .foregroundColor(.white)
                }
                HStack {
                    Image(systemName: accessory.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 60, maxHeight: 40, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                    Spacer()
                }
                Text(accessory.name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
            }
            .frame(width: 170, height: 170)
            .background(
                Group {
                    if isAccessoryOn {
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .top, endPoint: .bottom)
                    } else {
                        Color.gray
                    }
                }
            )
            .cornerRadius(25)
            .animation(.easeInOut(duration: 0.4), value: isAccessoryOn)
            .contextMenu(ContextMenu(menuItems: {
                Button(action: {
                    withAnimation {
                        isAccessoryOn.toggle()
                    }
                    print(isAccessoryOn ? "Аксессуар включен" : "Аксессуар выключен")
                }) {
                    Image(systemName: isAccessoryOn ? "minus" : "plus")
                    Text(isAccessoryOn ? "Выключить аксессуар" : "Включить аксессуар")
                }
            }))
            .padding(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
