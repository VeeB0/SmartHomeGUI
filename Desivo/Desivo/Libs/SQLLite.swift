import SwiftUI
import CoreData

struct sql {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>

    private func addUser() {
        withAnimation {
            let newUser = User(context: viewContext)
            newUser.id = UUID()
            newUser.name = "New User"
            newUser.email = "newuser@example.com"
            newUser.password = "password"
            newUser.additionalData = "Some additional data"

            saveContext()
        }
    }

    private func deleteUsers(offsets: IndexSet) {
        withAnimation {
            offsets.map { users[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct UserDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var user: User

    var body: some View {
        Form {
            Section(header: Text("User Details")) {
                TextField("Name", text: Binding($user.name, ""))
                TextField("Email", text: Binding($user.email, ""))
                TextField("Password", text: Binding($user.password, ""))
                TextField("Additional Data", text: Binding($user.additionalData, ""))
            }
            Section {
                Button("Save") {
                    saveContext()
                }
            }
        }
        .navigationTitle("User Details")
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

final class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
