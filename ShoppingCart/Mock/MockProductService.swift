//
//  MockProductService.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation

class MockProductService: ProductServiceType {
    var loading: Bool = false
    
    var products: [Product] = [Product.default]
    
    var cart = Cart(items: [], itemCount: 0, total: 0)
    var ref = MockDatabaseReference().child("products")
    func productList(completionHandler: @escaping ([Product]) -> Void) {
        completionHandler(products)
    }
    
    func numberOfCartItems() -> Int {
        return cart.itemCount
    }
    
    func addProductToCart(_ product: Product, units: Int) {
        cart.itemCount += units
        cart.total += product.price
        let item = Item(id: "1", product: product, units: 1)
        cart.items.append(item)
    }
    
    func cartItems() -> Cart {
        return cart
    }
    
    func checkout() {
        cart = Cart(items: [], itemCount: 0, total: 0)
    }
    
    func itemExists(id:String) -> Int? {
        return cart.items.firstIndex(where: { $0.id == id })
    }
    
    func addItemUnit( id: String) {
        guard let index = itemExists(id: id) else { return }
        cart.items[index].units += 1
    }
    
    func removeItemUnit( id: String) {
        guard let index = itemExists(id: id) else { return }
        cart.items[index].units += 1
    }
}
