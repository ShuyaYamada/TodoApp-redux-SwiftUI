//
//  ItemListView.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct ItemListView: View {
    
    @EnvironmentObject var store: AppStore
    @State var isEdit: Bool = false
    @State var isCreateItemMode: Bool = false
    @State var isTitleEdtiMode: Bool = false
    @State var index: Int = 0
    
    @State var tappedItem: Item = Item(id: "", title: "", listID: "")
    
    var itemList: ItemList

    var body: some View {
        ZStack {
            
            NavigationView {
                ScrollView {
                    ForEach(self.store.state.itemLists[index].items) { item in
                        ItemCell(isEdit: self.$isEdit, item: item) {
                            self.tappedItem = item
                            if self.isEdit {
                                self.store.dispatch(action: .removeItem(item: self.tappedItem, num: self.index))
                            }else {
                                self.isTitleEdtiMode = true
                            }
                        }
                        .sheet(isPresented: self.$isTitleEdtiMode) {
                            ItemTitleEditView(isTitleEdtiMode: self.$isTitleEdtiMode, item: self.tappedItem, index: self.index)
                                .environmentObject(self.store)
                        }
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
            
            CreateItemButton(isCreateItemMode: self.$isCreateItemMode)
            .sheet(isPresented: self.$isCreateItemMode) {
                CreateItemView(isCreateItemMode: self.$isCreateItemMode, listID: self.itemList.id)
                    .environmentObject(self.store)
            }
        }
            
        .navigationBarItems(trailing: EditButton(isEdit: $isEdit, action: {
            self.isEdit.toggle()
        }))
        .navigationBarTitle(itemList.title)
        
        .onAppear() {
            self.SetIndex()
        }
    }
    
    func SetIndex() {
        var num = 0
        for data in self.store.state.itemLists {
            num += 1
            if data.id == self.itemList.id {
                self.index = num-1
            }
        }
    }
}
