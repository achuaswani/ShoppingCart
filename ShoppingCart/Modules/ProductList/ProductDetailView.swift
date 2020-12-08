//
//  ProductDetailView.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    var viewModel: ProductListViewModel
    @Environment(\.imageCache) var cache: ImageCache
    var body: some View {
        ScrollView(.vertical) {
            VStack() {
                Spacer()
                HStack {
                    Spacer()
                    getImageURL()
                        .frame(height: 150)
                    Spacer()
                }
                Spacer()
                productDetails
                    .frame(width: 300.0, height: 100)
                    .position(x: 70, y: 40)
                                    
            }
            .background(Color.white.cornerRadius(25))
            .shadow(radius: 10.0, x: 20, y: 10)
         }
        buttonView
    }
    
    func getImageURL() -> AnyView {
        return  AnyView(AsyncImage(
                       urlString: product.image_url,
                       placeholder: Image("noImage"),
                       cache: self.cache,
                       configuration: { $0.resizable() }
                   )
            .aspectRatio(contentMode: .fit))
    }
    
    var productDetails: some View {
           VStack(alignment: .leading) {
               Text("Rs."+String(product.price))
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
            
               Text(product.name)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                   
               Text(product.category_name)
                .font(.system(size: 16, weight: .light, design: .rounded))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
           }
       }
    
    var buttonView: some View {
        VStack {
            Button(action: addToCart) {
                Text("Add to cart")
            }.padding(.top, 50)
            .buttonStyle(PrimaryButton())
        }
    }
    
    func addToCart() {
        viewModel.addToCart(product: product)
    }
}

#if DEBUG
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProductListViewModel(service:ProductService())
        return ProductDetailView(product: Product.default, viewModel: viewModel)
    }
}
#endif
