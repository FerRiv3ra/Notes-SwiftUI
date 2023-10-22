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
    
    func saveData(context: NSManagedObjectContext){
        let newNote = Notes(context: context);
        newNote.note = note;
        newNote.date = date;
        
        do {
            try context.save()
            show.toggle()
        } catch let error as NSError {
            print("No se guardo", error.localizedDescription)
        }
    }
}
