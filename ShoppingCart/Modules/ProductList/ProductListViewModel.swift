//
//  ProductListViewModel.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation

class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var categories = [String]()
    @Published var cart: Cart?
    var service: ProductServiceType

    init(service: ProductServiceType) {
        self.service = service
        loadProducts()
    }
    
    func loadProducts() {
        self.service.productList() { items in
            self.products = items
            self.getCategories()
        }
    }
    
    func getCategories() {
        for product in products where !categories.contains(product.category_name) {
            categories.append(product.category_name)
        }
    }
    
    func addProductToCart(_ product: Product) {
        service.addProductToCart(product, units: 1)
    }
}
