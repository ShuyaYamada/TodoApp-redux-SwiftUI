//
//  AppAction.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/07/31.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import Foundation

enum AppAction {
    case addItemList(itemList: ItemList)
    case updateItemListTitle(itemList: ItemList, newTitle: String)
    case removeItemList(itemList:ItemList)
    case addItem(item: Item)
    case updateItem(item: Item, newTitle: String, num: Int)
    case removeItem(item: Item, num: Int)
}
