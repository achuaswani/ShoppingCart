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

    init(product: Product, service: ProductServiceType) {
        self.product = product
        self.service = service
    }
    
    func addToCart(product: Product) {
        service.addToCart(product: product)
    }

}
