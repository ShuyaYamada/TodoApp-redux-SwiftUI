//
//  CreateItemView.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct CreateItemView: View {
    
    @EnvironmentObject var store: AppStore
    
    @Binding var isCreateItemMode: Bool
    
    @State var titleText: String = ""
    
    var listID: String
    
    var body: some View {
        NavigationView {
            Form {
                TextField("名称", text: $titleText)
            }.navigationBarTitle("新規アイテム", displayMode: .inline)
            
            .navigationBarItems(
                leading: Button(action: {
                    self.isCreateItemMode.toggle()
                }, label: {
                    Text("キャンセル")
                }),
                trailing: Button(action: {
                    let item = Item(id: UUID().uuidString, title: self.titleText, listID: self.listID)
                    self.store.dispatch(action: .addItem(item: item))
                    self.isCreateItemMode.toggle()
                }, label: {
                    Text("保存")
                }).disabled(titleText.isEmpty)
            )
        }
    }
}
