//
//  CartItemsCard.swift
//  ShoppingCart
//
//  Created by Aswani G on 8/29/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct CartItemsCard: View {
    @State var item: Item = Item.default
    @Environment(\.imageCache) var cache: ImageCache
    @ObservedObject
    var viewModel: CartViewModel
    
    @ViewBuilder
    var body: some View {
        HStack {
            getImageURL().frame(height: 100)
            VStack {
                Text(item.product.name)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("Price: \(item.product.price)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.trailing)
            }
            Spacer()
            Text("Units: ")
                .font(.system(size: 24, weight: .bold, design: .rounded))
            Button(action: addItemUnit) {
                
                Image(systemName: "plus")
                    .buttonStyle(AddButton())
            }
            
            Text("\(item.units)")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .fontWeight(.bold)
            
            Button(action: removeItemUnit) {
                
                Image(systemName: "minus")
                    .buttonStyle(AddButton())
            }
        }
        .frame(height:120)
    }
    
    func getImageURL() -> AnyView {
        return  AnyView(AsyncImage(
                       urlString: item.product.image_url,
                       placeholder: Image("noImage"),
                       cache: self.cache,
                       configuration: { $0.resizable() }
                   )
                    .aspectRatio(contentMode: .fit))
    }
    
    func addItemUnit() {
        item.units += 1
        viewModel.addItemUnit(id: item.id)
    }
    
    func removeItemUnit() {
        if item.units > 1{
            item.units -= 1
            viewModel.removeItemUnit(id: item.id)
        }
    }
}

struct CartItemsCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CartViewModel(service:ProductService())
        CartItemsCard(item: Item.default, viewModel: viewModel)
    }
}
