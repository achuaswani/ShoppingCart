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
    
    var products: [Product] = []
    
    var cart = Cart(items: [], itemCount: 0, total: 0)
    var ref = MockDatabaseReference().child("products")
    func productList(completionHandler: @escaping ([Product]) -> Void) {
        completionHandler(products)
    }
    
    func productDetails(productId: String) -> Product {
        let details = products.first{ $0.id == productId }
        return details!
    }
    
    func numberOfCartItems() -> Int {
        return cart.itemCount
    }
    
    func addToCart(productId: String) {
        guard let product = (products.first{ $0.id == productId }) else { return }
        cart.itemCount += 1
        cart.total += product.price
        updateItemCart(product: product)
        
    }
    
    func cartItems() -> Cart {
        return cart
    }
    
    func checkout() {
        for item in cart.items {
            if !productAvailable(id: item.id) {
                continue
            }
        }
        cart = Cart(items: [], itemCount: 0, total: 0)
    }
    
    func updateItemCart(product: Product) {
        let item = Item(id: "1", product: product, units: 1)
        cart.items.append(item)
    }
    
    func productAvailable(id: String) -> Bool {
        return true
    }
}
