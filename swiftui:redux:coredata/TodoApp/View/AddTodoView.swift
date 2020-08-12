//
//  AddTodoView.swift
//  TodoApp
//
//  Created by ShuyaYamada on 2020/01/20.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct AddTodoView: View {
    
    @EnvironmentObject var store: AppStore
    
    @Binding var isAddingMode: Bool
    
    @State var titleText: String = ""
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                TextField("Title", text: $titleText)
                
            }.navigationBarTitle("New Todo", displayMode: .inline)
                
            .navigationBarItems(
                
                leading: Button(action: {
                    
                    self.isAddingMode.toggle()
                    
                }, label: {
                    
                    Text("Cancel")
                }),
                
                trailing: Button(action: {
                    
                    let todo = Todo(id: UUID().uuidString, title: self.titleText)
                    
                    self.store.dispatch(action: .addTodo(todo: todo))
                    
                    self.isAddingMode.toggle()
                    
                }, label: {
                    
                    Text("Save")
                    
                }).disabled(titleText.isEmpty)
            )
        }
    }
}
