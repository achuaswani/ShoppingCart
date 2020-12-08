//
//  BaseStyle.swift
//  ShoppingCart
//
//  Created by Aswani G on 9/5/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

public struct PrimaryButton: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.normalButton)
                .cornerRadius(15.0)
                .shadow(radius: 10.0, x: 20, y: 10)
        }
}

public struct AddButton: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: 20))
                .foregroundColor(Color("Color1"))
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

extension Color {
    static var normalTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }

    static var normalButton: Color {
        return Color(red: 88.0/255.0, green: 199/255.0, blue: 199.0/255.0, opacity: 1.0)
    }
}
