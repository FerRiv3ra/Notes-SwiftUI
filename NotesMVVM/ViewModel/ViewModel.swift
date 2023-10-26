//
//  ViewModel.swift
//  NotesMVVM
//
//  Created by Fernando Rivera on 22/10/23.
//

import Foundation
import CoreData
import Swift

class ViewModel: ObservableObject{
    @Published var note = "";
    @Published var date = Date();
    @Published var show = false;
    @Published var updatedNote: Notes!
    
    func saveData(context: NSManagedObjectContext){
        let newNote = Notes(context: context);
        newNote.note = note;
        newNote.date = date;
        
        do {
            try context.save()
            show.toggle()
            note = ""
            date = Date()
        } catch let error as NSError {
            print("No se guardo", error.localizedDescription)
        }
    }

    func deleteData(item: Notes, context: NSManagedObjectContext){
        context.delete(item)
//        try! context.save()
        do {
            try context.save()
        } catch let error as NSError {
            print("No se elimino", error.localizedDescription)
        }
    }
    
    func sendData(item: Notes){
        updatedNote = item
        note = item.note ?? ""
        date = item.date ?? Date()
        show.toggle()
    }
    
    func updateData(context: NSManagedObjectContext){
        updatedNote.note = note
        updatedNote.date = date
        do {
            try context.save()
            show.toggle()
            note = ""
            date = Date()
            updatedNote = nil
        } catch let error as NSError {
            print("No se edito", error.localizedDescription)
        }
    }
    
    func clean(){
        note = ""
        date = Date()
        updatedNote = nil
    }
}
