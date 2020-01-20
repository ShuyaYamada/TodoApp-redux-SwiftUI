//
//  ContentView.swift
//  TodoApp
//
//  Created by ShuyaYamada on 2020/01/20.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: AppStore
    
    @State var isAddingMode: Bool = false
    
    @State var isUpdatingMode: Bool = false
    
    @State var isEdit: Bool = false
    
    @State var selectedTodo: Todo = Todo(id: "", title: "")

    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.bottom)
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        self.isEdit.toggle()
                    }) {
                        
                        Text(self.isEdit ? "Done" : "Edit").fontWeight(.heavy)
                    }
                    
                    Spacer()
                    
                    Text("TodoApp").font(.largeTitle).fontWeight(.heavy).padding(.bottom, 15)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.isAddingMode.toggle()
                    }) {
                        
                        Image(systemName: "plus").font(.title)
                        
                    }.sheet(isPresented: $isAddingMode) {
                        
                        AddTodoView(isAddingMode: self.$isAddingMode).environmentObject(self.store)
                    }
                    
                }.padding([.leading,.trailing], 15)
                 .padding(.top, 20)
                 .background(Color.white)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 10) {
                        
                        ForEach(store.state.todos) { todo in
                            
                            TodoCell(isEdit: self.$isEdit, todo: todo).environmentObject(self.store)
                                
                                .onTapGesture {
                                  
                                    self.selectedTodo = todo
                                    
                                    self.isUpdatingMode.toggle()
                                    
                            }.sheet(isPresented: self.$isUpdatingMode) {
                                
                                UpdateTodoView(isUpdatingMode: self.$isUpdatingMode, selectedTodo: self.$selectedTodo).environmentObject(self.store)
                            }
                        }
                        
                    }.padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
