//
//  Home.swift
//  NotesMVVM
//
//  Created by Fernando Rivera on 22/10/23.
//

import SwiftUI

struct Home: View {
    @StateObject var model = ViewModel()
    @FetchRequest(entity: Notes.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results: FetchedResults<Notes>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(results){ item in
                    VStack(alignment: .leading){
                        Text(item.note ?? "Vacía").font(.title).bold()
                        Text(item.date ?? Date(), style: .date)
                    }
                }
            }.navigationTitle("Notas")
                .navigationBarItems(trailing: Button(action: {
                    model.show.toggle()
                }){
                    Text("+").bold().font(.title)
                }.sheet(isPresented: $model.show, content: {AddView(model: model)}))
        }
    }
}
