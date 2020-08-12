//
//  ListTableView.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct ListTableView: View {
    
    @ObservedObject var store: AppStore
    
    @State var isEdit: Bool = false
    @State var isItemListMode: Bool = false
    @State var isActionSheetMode: Bool = false
    @State var isTitleEdtiMode: Bool = false
    @State var isCreateListMode: Bool = false
    
    @State var tappedList: ItemList = ItemList(id: "", title: "", items: [])
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        ForEach(store.state.itemLists) { list in
                            ItemListCell(isEdit: self.$isEdit, itemList: list) {
                                self.tappedList = list
                                if self.isEdit {
                                    self.isActionSheetMode = true
                                }else {
                                    self.isItemListMode = true
                                }
                            }
                                
                            .actionSheet(isPresented: self.$isActionSheetMode) {
                                self.ShowActionSheet(edit: {
                                    self.isTitleEdtiMode = true
                                    self.isEdit = false
                                }, remove: {
                                    self.store.dispatch(action: .removeItemList(itemList: self.tappedList))
                                    self.isEdit = false
                                })
                            }
                                
                            .sheet(isPresented: self.$isTitleEdtiMode) {
                                ListTitleEditView(isTitleEdtiMode: self.$isTitleEdtiMode, list: self.tappedList)
                                    .environmentObject(self.store)
                            }
                        }
                    }
                }
                
                
                CreateListButton(isCreateListMode: self.$isCreateListMode)
                .sheet(isPresented: self.$isCreateListMode) {
                    CreateListView(isCreateListMode: self.$isCreateListMode).environmentObject(self.store)
                }
                
                NavigationLink(destination: ItemListView(itemList: self.tappedList).environmentObject(self.store), isActive: self.$isItemListMode) {
                    EmptyView()
                }
                .navigationBarItems(trailing: EditButton(isEdit: $isEdit, action: {
                    self.isEdit.toggle()
                }))
                .navigationBarTitle("リスト一覧")
            }
        }
    }
    
    func ShowActionSheet(edit: @escaping () -> Void, remove:  @escaping () -> Void) -> ActionSheet {
        return ActionSheet(title: Text("Listの編集"), buttons: [
            .default(Text("名称変更"), action: edit),
            .destructive(Text("削除"), action: remove),
            .cancel()
        ])
    }
}

