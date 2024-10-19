//
//  TLButtonView.swift
//  ToDoListApp
//
//  Created by alinabi on 10/19/24.
//

import SwiftUI

struct TLButtonView: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(backgroundColor)
                
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
         
    }
}

#Preview {
    TLButtonView(title: "AAA", backgroundColor: .pink){
        //Action
    }
}
