//
//  ListEditButton.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct EditButton: View {
    
    @Binding var isEdit: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(isEdit ? "完了" : "編集").foregroundColor(.blue)
        }
    }
}
