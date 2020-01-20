//
//  UpdateTodoView.swift
//  TodoApp
//
//  Created by ShuyaYamada on 2020/01/20.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct UpdateTodoView: View {
    
    @EnvironmentObject var store: AppStore
    
    @Binding var isUpdatingMode: Bool
    
    @Binding var selectedTodo: Todo
    
    @State var titleText = ""
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                TextField("\(selectedTodo.title)", text: $titleText)
                
            }.navigationBarTitle("Update Todo", displayMode: .inline)
                
            .navigationBarItems(
                
                leading: Button(action: {
                    
                    self.isUpdatingMode.toggle()
                    
                }, label: {
                    
                    Text("Cancel")
                }),
                
                trailing: Button(action: {
                                        
                    self.store.dispatch(action: .updateTodo(id: self.selectedTodo.id, title: self.titleText))
                    
                    self.isUpdatingMode.toggle()
                    
                }, label: {
                    
                    Text("Update")
                    
                }).disabled(titleText.isEmpty)
            )
        }
    }
}
