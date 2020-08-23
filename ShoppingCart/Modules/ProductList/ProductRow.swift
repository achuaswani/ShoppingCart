//
//  ProductRow.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    var body: some View {
       ZStack {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(Color.gray)
           
            VStack(alignment: .leading) {
                NavigationLink(
                destination: ProductDetailView(product: product)) {
                    HStack() {
                        getImageURL()
                        productDetails
                    }
                }
                .font(.subheadline)
                .padding(5)
            }
            .padding(5)
            .multilineTextAlignment(.center)
       }
    }
    
    func getImageURL() -> AnyView {
        return  AnyView(AsyncImage(
                       urlString: product.imageURL,
                       placeholder: Image("noImage")
                        .foregroundColor(Color.black)
                   )
            .padding(20)
            .aspectRatio(contentMode: .fit))
    }
}

extension ProductRow {
    
    var productDetails: some View {
        VStack(alignment: .trailing, spacing: 0.0) {
            Text(product.name).font(.headline).foregroundColor(Color.black).multilineTextAlignment(.trailing)
                
            Text(product.categoryName)
                .font(.subheadline)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.trailing)
            Spacer().frame(height: 20)

            Text("Rs."+String(product.price))
                .font(.subheadline)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.trailing)
        }
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        let productDict: [String : Any] = [
            "id": "String",
            "name": "Name ",
            "price": 1.2,
            "image_url": "String",
            "description": "String",
            "category_name" : "Category",
            "images": ["String"],
            "isAvailable": false
            ]
        return ProductRow(product: Product(productDict: productDict)!)
    }
}
#endif
