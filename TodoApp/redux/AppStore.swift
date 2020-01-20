//
//  AppStore.swift
//  TodoApp
//
//  Created by ShuyaYamada on 2020/01/20.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI
import CoreData

final class AppStore: ObservableObject {
    
    @Published private(set) var state: AppState
    
    init(state: AppState = .init(todos: [Todo]())) {
        
        self.state = state
        
        let app = UIApplication.shared.delegate as! AppDelegate
        
        let context = app.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoData")
        
        do {
            
            let response = try context.fetch(request)
            
            for data in response as! [NSManagedObject] {
                
                let id = data.value(forKey: "id") as! String
                
                let title = data.value(forKey: "title") as! String
                
                self.state.todos.append(Todo(id: id, title: title))
            }
            
        }catch {
            
            print(error.localizedDescription)
        }
    }
    
    public func dispatch(action: AppAction) {
        
        state = appReducer(state: state, action: action)
    }
}
