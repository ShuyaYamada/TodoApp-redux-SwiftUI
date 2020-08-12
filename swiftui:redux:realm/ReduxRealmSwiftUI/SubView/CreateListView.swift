//
//  CreateListView.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct CreateListView: View {
    
    @EnvironmentObject var store: AppStore
    
    @Binding var isCreateListMode: Bool
    
    @State var titleText: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("名称", text: $titleText)
            }.navigationBarTitle("新規リスト", displayMode: .inline)
            
            .navigationBarItems(
                leading: Button(action: {
                    self.isCreateListMode.toggle()
                }, label: {
                    Text("キャンセル")
                }),
                trailing: Button(action: {
                    let itemList = ItemList(id: UUID().uuidString, title: self.titleText, items: [])
                    self.store.dispatch(action: .addItemList(itemList: itemList))
                    self.isCreateListMode.toggle()
                }, label: {
                    Text("保存")
                }).disabled(titleText.isEmpty)
            )
        }
    }
}
