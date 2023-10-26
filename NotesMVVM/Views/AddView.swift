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
                Text(model.updatedNote != nil ? "Editar nota":"Agregar nota").font(.title).bold().foregroundColor(.white)
                Spacer()
                TextEditor(text: $model.note)
                Divider()
                DatePicker("Seleccionar fecha", selection: $model.date)
                Spacer()
                Button(action :{
                    if model.updatedNote != nil {
                        model.updateData(context: context)
                    }else{
                        model.saveData(context: context)
                    }
                }){
                    Label(
                        title: {Text(model.updatedNote != nil ? "Actualizar":"Guardar").bold().foregroundColor(.white)},
                        icon: {Image(systemName: "checkmark.seal.fill").foregroundColor(.white)}
                    )
                }.padding()
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(model.note == "" ? .gray : .indigo)
                    .cornerRadius(8)
                    .disabled(model.note == "" ? true:false)
            }.padding()
        }.onDisappear{
            model.clean()
        }
    }
}

