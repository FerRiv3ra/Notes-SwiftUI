//
//  AddView.swift
//  NotesMVVM
//
//  Created by Fernando Rivera on 22/10/23.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var model: ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Gradient(colors: [.indigo, .purple]))
                .ignoresSafeArea()
            VStack{
                Text("Agregar nota").font(.title).bold().foregroundColor(.white)
                Spacer()
                TextEditor(text: $model.note)
                Divider()
                DatePicker("Seleccionar fecha", selection: $model.date)
                Spacer()
                Button(action :{
                    model.saveData(context: context)
                }){
                    Label(
                        title: {Text("Guardar").bold().foregroundColor(.white)},
                        icon: {Image(systemName: "plus").foregroundColor(.white)}
                    )
                }.padding()
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(.indigo).cornerRadius(8)
            }.padding()
        }
    }
}

