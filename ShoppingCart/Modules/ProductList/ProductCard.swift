//
//  ProductRow.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct ProductCard: View {
    var product: Product
    var viewModel: ProductListViewModel
    @Environment(\.imageCache) var cache: ImageCache

    var body: some View {
        NavigationLink(destination: ProductDetailView(product: product, viewModel: viewModel)) {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                VStack(spacing: 15) {
                    Spacer()
                    HStack(spacing: 15) {
                        getImageURL()
                        productDetails
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.trailing,8)
                }
                HStack() {
                Text("Rs."+String(product.price))
                    .foregroundColor(Color.black.opacity(0.6))
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("price"))
                    .clipShape(CustomCorner(corners: [.topRight,.bottomLeft], size: 15))
                Spacer()
                Text("Add to cart")
                    .foregroundColor(Color.black.opacity(0.6))
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("price"))
                    .clipShape(CustomCorner(corners: [.topLeft,.bottomRight], size: 15))
                    .onTapGesture {
                        viewModel.addToCart(product: product)
                    }
                }
            }
            .background(Color("cardBg").cornerRadius(25))
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func getImageURL() -> AnyView {
        return  AnyView(AsyncImage(
                       urlString: product.image_url,
                       placeholder: Image("noImage"),
                       cache: self.cache,
                       configuration: { $0.resizable() }
                   )
                    .frame(height: 180)
                    .padding(20)
                    .aspectRatio(contentMode: .fit))
    }

    var productDetails: some View {
        VStack(alignment: .trailing, spacing: 0.0) {
            Text(product.name)
                //.font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Text(product.category_name)
                .font(.subheadline)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.trailing)
            Spacer().frame(height: 20)
        }
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProductListViewModel(service:ProductService())
        return ProductCard(product: Product.default, viewModel: viewModel)
    }
}
#endif
