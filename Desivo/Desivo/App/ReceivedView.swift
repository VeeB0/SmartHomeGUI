import SwiftUI

struct ReceivedView: View {
    @State private var useLargeTitle = true
    @State private var showingAddAccessoryView = false
    @State private var rooms = [
        Room(name: "Гараж", temperature: 22, devices: 9, imageName: "door.garage.double.bay.closed"),
        Room(name: "Кухня", temperature: 21, devices: 8, imageName: "microwave.fill"),
        Room(name: "Спальня", temperature: 20, devices: 3, imageName: "bed.double.fill"),
        Room(name: "Теплица", temperature: 32, devices: 2, imageName: "sprinkler.and.droplets.fill"),
        Room(name: "Ванная", temperature: 28, devices: 2, imageName: "bathtub.fill")
    ]
    
    @State private var accessories = [
        Accessory(name: "Отопление", imageName: "thermometer")
    ]

    var body: some View {
        NavigationView {
            ScrollView (.vertical) {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 150))]){
                    ForEach(accessories) { accessory in
                        MainAccessoryView(accessory: accessory)
                    }
                }
                
                GeometryReader { geometry in
                    Color.clear.preference(key: OffsetKey.self, value: geometry.frame(in: .named("scroll")).minY)
                }
                .frame(height: 1)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(rooms) { room in
                        RoomView(room: room)
                    }
                }
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(rooms) { room in
                        RoomView(room: room)
                    }
                }
                .navigationBarItems(trailing:
                        Menu {
                            Button("Добавить комнату", action: { addRoom() })
                            Button("Добавить аксессуар", action: { showingAddAccessoryView = true })
                } label: {
                    Label("Добавить", systemImage: "plus")
                }
                )
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(OffsetKey.self) { minY in
                withAnimation {
                    useLargeTitle = minY > -100
                }
            }
            .navigationBarTitle("Главная", displayMode: useLargeTitle ? .large : .inline)
            .sheet(isPresented: $showingAddAccessoryView) {
                AddAccessoryView()
            }
        }
    }
    func addRoom() {
        rooms.append(Room(name: "Новая комната", temperature: 20, devices: 1, imageName: "house"))
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedView()
    }
}
