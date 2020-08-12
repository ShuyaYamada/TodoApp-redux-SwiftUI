//
//  ItemCell.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct ItemCell: View {
    
    @Binding var isEdit: Bool
    var item: Item
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(item.title).foregroundColor(.black)
                Spacer()
                Image(systemName: isEdit ? "trash" : "square.and.pencil").foregroundColor(isEdit ? .red : .blue)
            }.padding()
        }
        
    }
}
