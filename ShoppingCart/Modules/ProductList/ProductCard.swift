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
        NavigationLink(destination: ProductDetailView(viewModel: ProductDetailViewModel(product: product, service: viewModel.service))) {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                VStack(spacing: 15) {
                    HStack {
                        getImageURL()
                            .padding(.bottom, 50)
                        productDetails
                            .padding(.bottom, 50)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.trailing,8)
                }
                HStack {
                Text("Rs."+String(product.price))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.6))
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("cardBg"))
                    .clipShape(CustomCorner(corners: [.topRight,.bottomLeft], size: 15))
                Spacer()
                Text("Add to cart")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.6))
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color("cardBg"))
                    .clipShape(CustomCorner(corners: [.topLeft,.bottomRight], size: 15))
                    .onTapGesture {
                        viewModel.addProductToCart(product)
                    }
                }
            }
            .background(Color.white.cornerRadius(25))
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func getImageURL() -> AnyView {
        return  AnyView(
            AsyncImage(
                       urlString: product.imageURL,
                       placeholder: Image("noImage"),
                       cache: self.cache,
                       configuration: { $0.resizable() }
                   )
                    .frame(height: 160)
                    .padding(20)
                    .aspectRatio(contentMode: .fit)
            )
    }

    var productDetails: some View {
        VStack(alignment: .trailing, spacing: 0.0) {
            Text(product.name)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.black)
            Text(product.categoryName)
                .font(.system(size: 16, weight: .bold, design: .rounded))
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
