//
//  CartViewModel.swift
//  ShoppingCart
//
//  Created by Aswani G on 8/29/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

class CartViewModel: ObservableObject {
    var cart: Cart?
    private var service: ProductServiceType

    init(service: ProductServiceType) {
        self.service = service
        self.cartItems()
    }
    
    func cartItems() {
        cart = service.cartItems()
    }
    
    func addItemUnit(id: String) {
        service.addItemUnit(id: id)
    }
    
    func removeItemUnit( id: String) {
        service.removeItemUnit(id: id)
    }
}
