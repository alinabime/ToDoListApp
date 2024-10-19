//
//  HeaderView.swift
//  ToDoListApp
//
//  Created by alinabi on 10/17/24.
//

import SwiftUI

struct HeaderView: View {
    let  title: String
    let subtitle: String
    let backgroundColor: Color
    let angle: Double
    var body: some View {
       
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(backgroundColor)
                .rotationEffect(Angle(degrees: angle))
                
            VStack {
                Text(title)
                    .foregroundColor(.white)
                    .font(Font.system(size: 50))
                    .bold()
                Text(subtitle)
                    .foregroundColor(.white)
                    .font(Font.system(size: 30  ))
            }      .padding(.top, 50)
    
             
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350 )
        .offset(y: -150)
    }
}

#Preview {
    HeaderView(title: "title", subtitle: "subtitle", backgroundColor: .blue, angle: 15)
}
