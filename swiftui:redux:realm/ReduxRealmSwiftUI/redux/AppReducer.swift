//
//  AppReducer.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/07/31.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import Foundation
import RealmSwift

func appReducer(state: AppState, action: AppAction) -> AppState {
    
    var state = state
    
    switch action {
        
    case .addItemList(let itemList):
        do {
            let realm = try Realm()
            let itemListData = ItemListData()
            itemListData.id = itemList.id
            itemListData.title = itemList.title
            try realm.write {
                realm.add(itemListData)
            }
            state.itemLists.append(itemList)
        }
        catch {
            print(error.localizedDescription)
        }
        
    case .updateItemListTitle(let itemList, let newTitle):
        do {
            let realm = try Realm()
            try realm.write {
                let itemListData = realm.objects(ItemListData.self)
                for data in itemListData {
                    if data.id == itemList.id {
                        data.title = newTitle
                    }
                }
                var index = 0
                for data in state.itemLists {
                    index += 1
                    if data.id == itemList.id {
                        state.itemLists[(index-1)].title = newTitle
                    }
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
    case .removeItemList(let itemList):
        do {
            let realm = try Realm()
            try realm.write {
                var index = 0
                for data in state.itemLists {
                    index += 1
                    if data.id == itemList.id {
                        state.itemLists.remove(at: (index-1))
                    }
                }
                let itemData = realm.objects(ItemData.self)
                for data in itemData {
                    if data.listID == itemList.id {
                        print(data)
                        realm.delete(data)
                    }
                }
                let itemListData = realm.objects(ItemListData.self)
                for data in itemListData {
                    if data.id == itemList.id {
                        realm.delete(data)
                    }
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
    case .addItem(let item):
        do {
            let realm = try Realm()
            let itemData = ItemData()
            itemData.id = item.id
            itemData.title = item.title
            itemData.listID = item.listID
            try realm.write {
                realm.add(itemData)
            }
            var index = 0
            for data in state.itemLists {
                index += 1
                if data.id == item.listID {
                    state.itemLists[(index-1)].items.append(item)
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
    case .updateItem(let item, let newTitle, let num):
        do {
            let realm = try Realm()
            try realm.write {
                let itemData = realm.objects(ItemData.self)
                for data in itemData {
                    if data.id == item.id {
                        data.title = newTitle
                    }
                }
                var index = 0
                for data in state.itemLists[num].items {
                    index += 1
                    if data.id == item.id {
                        state.itemLists[num].items[index-1].title = newTitle
                    }
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
    case .removeItem(let item, let num):
        do {
            let realm = try Realm()
            try realm.write {
                var index = 0
                for data in state.itemLists[num].items {
                    index += 1
                    if data.id == item.id {
                        state.itemLists[num].items.remove(at: index-1)
                    }
                }
                let itemData = realm.objects(ItemData.self)
                for data in itemData {
                    if data.id == item.id {
                        realm.delete(data)
                    }
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    return state
}
