//
//  Model.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/07/31.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import Foundation
import RealmSwift

struct Item: Identifiable {
    var id: String
    var title: String
    var listID: String
}

struct ItemList: Identifiable {
    var id: String
    var title: String
    var items: [Item]
}

class ItemData: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var listID: String = ""
}

class ItemListData: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
}
