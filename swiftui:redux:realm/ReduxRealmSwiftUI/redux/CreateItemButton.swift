//
//  CreateItemButton.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct CreateItemButton: View {
    
    @Binding var isCreateItemMode: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.isCreateItemMode = true
                }) {
                    Text("新規アイテム").bold()
                }
            }.padding()
        }
    }
}
