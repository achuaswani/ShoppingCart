//
//  CartView.swift
//  ShoppingCart
//
//  Created by Aswani G on 8/29/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct CartView: View {
    @ObservedObject
    var viewModel: CartViewModel
    @State var cart:Cart?
    @ViewBuilder
    var body: some View {
        if let cart = viewModel.cart, !cart.items.isEmpty {
            
            Text("My Cart")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
                .shadow(radius: 10.0, x: 20, y: 10)
            List {
                ForEach(cart.items) { item in
                    CartItemsCard(item: item, viewModel: viewModel)
                        .buttonStyle(PlainButtonStyle())
                }
                .onDelete(perform: delete)
            }
            .background(Color.white.cornerRadius(25))
            .shadow(radius: 10.0, x: 20, y: 10)
            .padding(5)
            Text("SubTotal(\(cart.itemCount) items): \(cart.total)")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
                .shadow(radius: 10.0, x: 20, y: 10)
            buttonView
        } else {
            Text("No item Available.")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
                .shadow(radius: 10.0, x: 20, y: 10)
        }
    }
    
    var buttonView: some View {
        VStack {
            Button(action: checkout) {
                Text("Proceed to checkout")
            }.padding(.top, 50)
            .buttonStyle(PrimaryButton())
        }
    }
    
    func checkout() {
        
    }
    
    func delete(at offsets: IndexSet) {
        cart?.items.remove(atOffsets: offsets)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CartViewModel(service:ProductService())
        CartView(viewModel: viewModel)
    }
}
