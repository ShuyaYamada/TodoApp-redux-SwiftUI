//
//  CreateListButton.swift
//  ReduxRealmSwiftUI
//
//  Created by ShuyaYamada on 2020/08/01.
//  Copyright © 2020 ShuyaYamada. All rights reserved.
//

import SwiftUI

struct CreateListButton: View {
    
    @Binding var isCreateListMode: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.isCreateListMode = true
                }) {
                    Text("新規リスト").bold()
                }
            }.padding()
        }
    }
}

