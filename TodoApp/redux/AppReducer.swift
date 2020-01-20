//
//  AppReducer.swift
//  TodoApp
//
//  Created by ShuyaYamada on 2020/01/20.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI
import CoreData

func appReducer(state: AppState, action: AppAction) -> AppState {
    
    var state = state
    
    switch action {
        
    case .addTodo(let todo):
        
        let app = UIApplication.shared.delegate as! AppDelegate
        
        let context = app.persistentContainer.viewContext
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: "TodoData", into: context)
        
        entity.setValue(todo.id, forKey: "id")
        
        entity.setValue(todo.title, forKey: "title")
        
        do {
            
            try context.save()
            
            state.todos.append(todo)
            
        }catch {
            
            print(error.localizedDescription)
        }
        
    case .removeTodo(let id):
        
        let app = UIApplication.shared.delegate as! AppDelegate
        
        let context = app.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoData")
        
        do {
            
            let response = try context.fetch(request)
            
            for data in response as! [NSManagedObject] {
                
                let coreDataId = data.value(forKey: "id") as! String
                
                if coreDataId == id {
                    
                    context.delete(data)
                    
                    try context.save()
                }
            }
            
            var index = 0
            
            for data in state.todos {
                
                index += 1
                
                if data.id == id {
                    
                    state.todos.remove(at: index - 1)
                }
            }
            
        }catch {
            
            print(error.localizedDescription)
        }
    case .updateTodo(let id, let title):

        let app = UIApplication.shared.delegate as! AppDelegate
        
        let context = app.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoData")
        
        do {
            
            let response = try context.fetch(request)
            
            for data in response as! [NSManagedObject] {
                
                let coreDataId = data.value(forKey: "id") as! String
                
                if coreDataId == id {
                    
                    data.setValue(title, forKey: "title")
                    
                    try context.save()
                }
            }
            
            var index = 0
            
            for data in state.todos {
                
                index += 1
                
                if data.id == id {
                    
                    state.todos[index - 1].title = title
                }
            }
            
        }catch {
            
            print(error.localizedDescription)
        }
    }
    
    return state
}
