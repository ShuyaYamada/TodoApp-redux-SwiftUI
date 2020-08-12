//
//  ContentView.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/07/31.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var store: AppStore
    @State var isActiveItemListView: Bool = false
    
    
    var body: some View {
        NavigationView {
            List(store.state.itemLists) { list in
                 Text(list.id)
                
            }.navigationBarItems(trailing: AddListButton(action: {self.AddList()}))
             .navigationBarTitle("List一覧")
        }
    }
    
    func ShowItemListEditSheet(edit: @escaping () -> Void, remove:  @escaping () -> Void) -> ActionSheet {
        return ActionSheet(title: Text("Listの編集"), buttons: [
            .default(Text("タイトル変更"), action: edit),
            .destructive(Text("Delete"), action: remove),
            .cancel()
        ])
    }
    
    func AddList() {
        let itemList = ItemList(id: UUID().uuidString, title: "New", items: [])
        self.store.dispatch(action: .addItemList(itemList: itemList))
    }
    
    func UpdateListTitle(_ itemList: ItemList, _ newTitle: String) {
        print(itemList)
        self.store.dispatch(action: .updateItemListTitle(itemList: itemList, newTitle: newTitle))
    }
    
    func RemoveList(_ itemList: ItemList) {
        print(itemList)
        self.store.dispatch(action: .removeItemList(itemList: itemList))
    }
    
}

struct AddListButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
        }.padding()
    }
}



