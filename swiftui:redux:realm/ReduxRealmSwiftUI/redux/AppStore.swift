//
//  AppStore.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/07/31.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import Foundation
import SwiftUI
import RealmSwift

final class AppStore: ObservableObject {
    
    @Published private(set) var state: AppState
    
    init(state: AppState = .init(itemLists: [ItemList]())) {
        self.state = state
        do {
            let realm = try Realm()
            //ItemListDataからItemListを用意
            let itemListData = realm.objects(ItemListData.self)
            for data in itemListData {
                let itemList = ItemList(id: data.id, title: data.title, items: [])
                self.state.itemLists.append(itemList)
            }
            //ItemDataからItemListのItemを用意
            let itemData = realm.objects(ItemData.self)
            for data in itemData {
                let item = Item(id: data.id, title: data.title, listID: data.listID)
                var index = 0
                for list in self.state.itemLists {
                    index += 1
                    if item.listID == list.id {
                        self.state.itemLists[(index-1)].items.append(item)
                    }
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    public func dispatch(action: AppAction) {
        state = appReducer(state: state, action: action)
    }
}
