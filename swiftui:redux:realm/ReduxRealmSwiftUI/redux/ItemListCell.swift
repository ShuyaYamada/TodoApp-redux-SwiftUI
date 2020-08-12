//
//  ItemListCell.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct ItemListCell: View {
    
    @Binding var isEdit: Bool
    var itemList: ItemList
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "folder").foregroundColor(.blue)
                Text(itemList.title).foregroundColor(.black)
                Spacer()
                Image(systemName: isEdit ? "ellipsis.circle" : "greaterthan").foregroundColor(.gray)
            }.padding()
        }
        
    }
}
