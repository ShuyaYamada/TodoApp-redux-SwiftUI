//
//  AppAction.swift
//  TodoApp
//
//  Created by ShuyaYamada on 2020/01/20.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import Foundation

enum AppAction {
    
    case addTodo(todo: Todo)
    
    case removeTodo(id: String)
    
    case updateTodo(id: String, title: String)
}
