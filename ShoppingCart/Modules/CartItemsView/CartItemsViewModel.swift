//
//  CartItemsViewModel.swift
//  ShoppingCart
//
//  Created by Aswani G on 12/8/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation

class CartItemsViewModel: ObservableObject {
    @Published var item: Item = Item.default
    var service: ProductServiceType
    init(item: Item, service: ProductServiceType) {
        self.item = item
        self.service = service
    }
    
    func addItemUnit() {
        addProductToCart(product: item.product)
    }
    
    func removeItemUnit() {
        if item.units > 0 {
            service.removeItemUnit(id: item.id)
        }
    }
    
    func addProductToCart(product: Product) {
        service.addProductToCart(product, units: 1)
    }
}
