//
//  ProductDetailViewModel.swift
//  ShoppingCart
//
//  Created by Aswani G on 12/7/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    var product: Product
    var service: ProductServiceType
    var productTypeArray = ["Blue", "Red", "White", "Yellow"]
    var priceTitle =  "product.details.approximate.price.title".localized()

    @Published var itemUnit = 0
    @Published var approximatePrice: String = ""
    
    var price: Double {
        return Double(product.price) * Double(itemUnit)
    }
    
    init(product: Product, service: ProductServiceType) {
        self.product = product
        self.service = service
        approximatePrice = "\(priceTitle)\(price)"
    }
    
    func addProductToCart() {
        service.addProductToCart(product, units: itemUnit)
    }
    
    func addItemUnit() {
        itemUnit += 1
        approximatePrice = "\(priceTitle)\(price)"
    }
    func removeItemUnit() {
        if itemUnit > 0 {
            itemUnit -= 1
        }
        approximatePrice = "\(priceTitle)\(price)"
    }

}
