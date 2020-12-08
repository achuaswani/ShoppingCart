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
        VStack() {
            Spacer()
            HStack {
                Spacer()
                getImageURL()
                    .frame(height: 300)
                Spacer()
            }
            Spacer()
            productDetails
         }
        .background(Color("BG"))
        .padding(.vertical)
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
           VStack(alignment: .trailing, spacing: 0.0) {
            Text(product.name).font(.headline).foregroundColor(Color.black).multilineTextAlignment(.center)
                   
               Text(product.category_name)
                   .font(.subheadline)
                   .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
               Spacer().frame(height: 20)

               Text("Rs."+String(product.price))
                   .font(.subheadline)
                   .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
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
