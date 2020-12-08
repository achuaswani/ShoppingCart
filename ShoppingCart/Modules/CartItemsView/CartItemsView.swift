//
//  CartItemsCard.swift
//  ShoppingCart
//
//  Created by Aswani G on 8/29/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct CartItemsView: View {
    @Environment(\.imageCache) var cache: ImageCache
    @ObservedObject var viewModel: CartItemsViewModel
    
    @ViewBuilder
    var body: some View {
        HStack {
            getImageURL().frame(height: 100)
            VStack {
                Text(viewModel.item.product.name)
                    .font(.system(size:18, weight: .bold, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                Text("Price: \(viewModel.item.product.price)")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
            }
            Spacer()
            Text("Units: ")
                .font(.system(size: 16, weight: .bold, design: .rounded))
            Button(action: viewModel.addItemUnit) {
                Image(systemName: "plus")
                    .buttonStyle(AddButton())
            }
            
            Text("\(viewModel.item.units)")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .fontWeight(.bold)
            
            Button(action: viewModel.removeItemUnit) {
                
                Image(systemName: "minus")
                    .buttonStyle(AddButton())
            }
        }
        .frame(height:120)
    }
    
    func getImageURL() -> AnyView {
        return  AnyView(AsyncImage(
            urlString: viewModel.item.product.image_url,
            placeholder: Image("noImage"),
            cache: self.cache,
            configuration: { $0.resizable() }
       )
        .aspectRatio(contentMode: .fit))
    }
}

struct CartItemsCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CartItemsViewModel(item: Item.default, service:ProductService())
        CartItemsView(viewModel: viewModel)
    }
}
