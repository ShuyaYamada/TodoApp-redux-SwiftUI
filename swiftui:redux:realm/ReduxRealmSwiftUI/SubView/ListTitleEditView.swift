//
//  ListTitleEditView.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct ListTitleEditView: View {
    
    @EnvironmentObject var store: AppStore
    
    @Binding var isTitleEdtiMode: Bool
    
    @State var titleText: String = ""
    
    var list: ItemList
    
    var body: some View {
        NavigationView {
            Form {
                TextField("名称", text: $titleText)
            }.navigationBarTitle("名称変更", displayMode: .inline)
            
            .navigationBarItems(
                leading: Button(action: {
                    self.isTitleEdtiMode.toggle()
                }, label: {
                    Text("キャンセル")
                }),
                trailing: Button(action: {
                    self.store.dispatch(action: .updateItemListTitle(itemList: self.list, newTitle: self.titleText))
                    self.isTitleEdtiMode.toggle()
                }, label: {
                    Text("保存")
                }).disabled(titleText.isEmpty)
            )
        }
    }
}
