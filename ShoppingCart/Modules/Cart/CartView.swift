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

    @ViewBuilder
    var body: some View {
        if viewModel.cart.items.isEmpty {
            Text("No item Available.")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
                .shadow(radius: 10.0, x: 20, y: 10)
        } else {
            Text("My Cart")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
            List {
                ForEach(viewModel.cart.items) { item in
                    CartItemsView(viewModel: CartItemsViewModel(item: item, service: viewModel.service))
                        .buttonStyle(PlainButtonStyle())
                }
                .onDelete(perform: delete)
            }
            .background(Color.white.cornerRadius(25))
            .padding(5)
            Text("SubTotal(\(viewModel.cart.itemCount) items): \(viewModel.cart.total)")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
                .shadow(radius: 10.0, x: 20, y: 10)
            buttonView
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
        viewModel.cart.items.remove(atOffsets: offsets)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CartViewModel(service:ProductService())
        CartView(viewModel: viewModel)
    }
}
