//
//  ContentView.swift
//  CoreData-TodoList
//
//  Created by Shinhyuk Park on 6/11/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Todo.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Todo.timestamp, ascending: true)])
    var todo: FetchedResults<Todo>
    
    @State var textFieldTitle = ""
    
    var body: some View {
        NavigationStack {
            HStack{
                TextField("",text: $textFieldTitle)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground).cornerRadius(10))
                Button(action: {addItem()}, label: {
                    Text("등록")
                        .padding()
                        .background(Color.yellow.cornerRadius(10))
                        .foregroundStyle(.black)
                        
                })
            }
            .padding(.horizontal,10)
            List{
                ForEach(todo) { items in
                    HStack{
                        Text(items.title ?? "없음")
                        Spacer()
                        Button {
                            toggleB(for: items)
                        } label: {
                            Image(systemName: items.status ? "checkmark" : "xmark")
                                .foregroundStyle(items.status ? .blue : .red)
                        }

                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("Core Data")
        }
    }
    
    
    private func toggleB(for item: Todo){
        withAnimation {
            item.status.toggle()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
        private func addItem() {
            withAnimation {
                let newTodo = Todo(context: viewContext)
                newTodo.title = textFieldTitle
                newTodo.timestamp = Date()
                textFieldTitle = ""
                
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
        private func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map { todo[$0] }.forEach(viewContext.delete)
                
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
