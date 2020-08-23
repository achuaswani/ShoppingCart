//
//  ProductService.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol ProductServiceType {
    var products: [Product] { get }
    var loading: Bool { get }
    func productList(completionHandler: @escaping ([Product]) -> Void)    
    func productDetails(productId: String) -> Product
    func numberOfCartItems() -> Int
    
    func cartItems() -> Cart
    func checkout()
}

class ProductService: ProductServiceType {
    
    @Published var products: [Product] = []
    @Published var loading = false
    
    var cart = Cart(items: [], itemCount: 0, total: 0)
    var ref: DatabaseReference = Database.database().reference().child("products")
    func productList(completionHandler: @escaping ([Product]) -> Void) {
        ref.observe(DataEventType.value) { (snapshot) in
            self.products = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let product = Product(snapshot: snapshot) {
                    self.products.append(product)
                }
            }
            completionHandler(self.products)
        }
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
        let cartItems = cart.items
        for index in 0..<cartItems.count {
            if !productAvailable(id: cartItems[index].id) {
                cart.items.remove(at: index)
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
    func uploadProduct(product: Product) {
        //Generates number going up as time goes on, sets order of TODO's by how old they are.
        let number = Int(Date.timeIntervalSinceReferenceDate * 1000)
        
        let postRef = ref.child(String(number))
        postRef.setValue(product)
    }
    
    func updateProduct(key: String, todo: String, isComplete: String) {
        let update = ["todo": todo, "isComplete": isComplete]
        let childUpdate = ["\(key)": update]
        ref.updateChildValues(childUpdate)
    }
}


