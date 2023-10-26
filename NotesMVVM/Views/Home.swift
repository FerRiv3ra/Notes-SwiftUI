//
//  Home.swift
//  NotesMVVM
//
//  Created by Fernando Rivera on 22/10/23.
//

import SwiftUI

struct Home: View {
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results: FetchedResults<Notes>
//    @FetchRequest(entity: Notes.entity(), sortDescriptors: [],
//                predicate: NSPredicate(format: "note CONTAINS[c] 'text'"),
//                animation: .spring()) var results: FetchedResults<Notes>

    
    var body: some View {
        NavigationView{
            List{
                ForEach(results){ item in
                    VStack(alignment: .leading){
                        Text(item.note ?? "Vacía").font(.title).bold()
                        Text(item.date ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            model.sendData(item: item)
                        }){
                            Label(title: {
                                Text("Editar")
                            },icon: {Image(systemName: "pencil")})
                        }
                        Button(action: {
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title: {
                                Text("Eliminar")
                            },icon: {Image(systemName: "trash")})
                        }
                    }))
                }
            }
            .navigationTitle("Notas")
                .navigationBarItems(trailing: Button(action: {
                    model.show.toggle()
                }){
                    Text("+").bold().font(.title)
                }.sheet(isPresented: $model.show, content: {AddView(model: model)}))
        }
    }
}
