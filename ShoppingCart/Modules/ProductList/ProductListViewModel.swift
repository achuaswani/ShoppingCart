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
    private var service: ProductServiceType

    init(service: ProductServiceType) {
        self.service = service
        loadProducts()
    }
    
    func loadProducts() {
        self.service.productList() { products in
            self.products = products
        }
    }
}
