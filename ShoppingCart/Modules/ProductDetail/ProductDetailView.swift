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
    var body: some View {
        VStack{
            HStack {
                Spacer()
                getImageURL()
                Spacer()
            }
            productDetails
         }
        .frame(minWidth: 0,
        maxWidth: .infinity,
        minHeight: 0,
        maxHeight: .infinity,
        alignment: .topLeading)
    }
    
    func getImageURL() -> AnyView {
        return  AnyView(AsyncImage(
                       urlString: product.imageURL,
                       placeholder: Image("noImage")
                        .padding()
                   )
            .aspectRatio(contentMode: .fit))
    }
    
    var productDetails: some View {
           VStack(alignment: .trailing, spacing: 0.0) {
            Text(product.name).font(.headline).foregroundColor(Color.black).multilineTextAlignment(.center)
                   
               Text(product.categoryName)
                   .font(.subheadline)
                   .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
               Spacer().frame(height: 20)

               Text("Rs."+String(product.price))
                   .font(.subheadline)
                   .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
           }
           .frame(maxWidth: .infinity)
       }
}

extension ProductDetailView {
    
}

#if DEBUG
struct ProductDetailView_Previews: PreviewProvider {
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
        return ProductDetailView(product: Product(productDict: productDict)!)
    }
}
#endif
