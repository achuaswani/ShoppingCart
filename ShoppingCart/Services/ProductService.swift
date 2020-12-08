//
//  ProductService.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CodableFirebase

protocol ProductServiceType {
    var products: [Product] { get }
    var loading: Bool { get }
    func productList(completionHandler: @escaping ([Product]) -> Void)
    func numberOfCartItems() -> Int
    func addToCart(product: Product)
    func cartItems() -> Cart
    func checkout()
    func addItemUnit(id: String)
    func removeItemUnit(id: String)
}

class ProductService: ProductServiceType {
    @Published var products: [Product] = [Product.default]
    @Published var loading = false
    
    var cart = Cart(items: [], itemCount: 0, total: 0)
    var ref: DatabaseReference = Database.database().reference().child("products")
    
    func productList(completionHandler: @escaping ([Product]) -> Void) {
        ref.observeSingleEvent(of: .value, with: { [weak self]  snapshot in
            guard let items = snapshot.value, let self = self else { return }
            do {
                self.products = try FirebaseDecoder().decode([Product].self, from: items)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
            completionHandler(self.products)
        })
    }
    
    func numberOfCartItems() -> Int {
        return cart.itemCount
    }
    
    func addToCart(product: Product) {
        cart.itemCount += 1
        cart.total += product.price
        updateItemCart(product: product)
        
    }
    
    func cartItems() -> Cart {
        return cart
    }
    
    func checkout() {
        cart = Cart(items: [], itemCount: 0, total: 0)
    }
    
    func updateItemCart(product: Product) {
        guard let index = itemExists(id:product.id) else {
            let item = Item(id: product.id, product: product, units: 1)
            cart.items.append(item)
            return
        }
        cart.items[index].units += 1
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
        cart.items[index].units -= 1
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


