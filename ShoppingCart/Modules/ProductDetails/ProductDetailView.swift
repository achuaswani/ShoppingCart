//
//  ProductDetailView.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    @Environment(\.imageCache) var cache: ImageCache
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
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
            .background(Color.white)
            .padding(2)
            productTypeListView
                .background(Color.white)
         }
        .background(Color("BG"))
        buttonView
    }
    
    func getImageURL() -> AnyView {
        return  AnyView(AsyncImage(
            urlString: viewModel.product.image_url,
                       placeholder: Image("noImage"),
                       cache: self.cache,
                       configuration: { $0.resizable() }
                   )
            .aspectRatio(contentMode: .fit))
    }
    
    var productDetails: some View {
       VStack(alignment: .leading) {
        Text("Rs."+String(viewModel.product.price))
            .font(.system(size: 24, weight: .bold, design: .rounded))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)
        
        Text(viewModel.product.name)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)
               
        Text(viewModel.product.category_name)
            .font(.system(size: 16, weight: .light, design: .rounded))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)
       }
    }
    
    var productTypeListView: some View {
        VStack {
            Text("Color/Style")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .position(x: 70, y: 10)
                .padding(.all, 5)
            ForEach(viewModel.productTypeArray, id: \.self) { item in
                    Text(item)
                        .font(.system(size: 16, weight: .light, design: .rounded))
                        .multilineTextAlignment(.leading)
                        .position(x: 50, y: 10)
                        .padding(.all, 5)
                Divider()
            }
            weightCardView
        }
    }
    
    var weightCardView: some View {
        VStack {
            Text("Units")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .fontWeight(.bold)
                .position(x: 50, y: 10)
                .padding(.all, 15)
            VStack {
                HStack(spacing: 50) {
                    Button(action: addItemUnit) {
                        
                        Image(systemName: "plus")
                            .buttonStyle(AddButton())
                    }
                    
                    //Text("\(item.units)")
                    Text("1")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .fontWeight(.bold)
                    
                    Button(action: removeItemUnit) {
                        
                        Image(systemName: "minus")
                            .buttonStyle(AddButton())
                    }
                }
                .frame(maxWidth: 300)
                .padding(.all, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )


            }
            .padding(.all, 20)
        }
    }
    
    var buttonView: some View {
        VStack {
            HStack {
                Text("Approximate  price ")
                    .font(.system(size: 24, weight: .light, design: .rounded))
                Text("$-.--")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
            }
            Button(action: addToCart) {
                Text("Add to cart")
            }.padding(.top, 50)
            .buttonStyle(PrimaryButton())
        }
    }
    
    func addToCart() {
        viewModel.addToCart(product: viewModel.product)
    }
    
    func addItemUnit() {
//        viewModel.product.units += 1
//        viewModel.addItemUnit(id: viewModel.product.id)
    }
    func removeItemUnit() {
//        if item.units > 1{
//            item.units -= 1
//            viewModel.removeItemUnit(id: item.id)
//        }
    }
    
}

#if DEBUG
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProductDetailViewModel(product: Product.default, service: ProductService())
        return ProductDetailView(viewModel: viewModel)
    }
}
#endif
