//
//  TodoCell.swift
//  TodoApp
//
//  Created by ShuyaYamada on 2020/01/20.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct TodoCell: View {
    
    @EnvironmentObject var store: AppStore
    
    @Binding var isEdit: Bool
    
    let todo: Todo
    
    var body: some View {
        
        HStack {
            
            if isEdit {
                
                Button(action: {
                    
                    self.store.dispatch(action: .removeTodo(id: self.todo.id))
                }) {
                    
                    Image(systemName: "minus.circle").font(.title)
                    
                }.foregroundColor(.red)
            }
            
            Text(todo.title)
            
            Spacer()
            
        }.padding()
        .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
        .animation(.spring())
    }
}
