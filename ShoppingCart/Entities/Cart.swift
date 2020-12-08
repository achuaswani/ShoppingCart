//
//  Cart.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation

struct Item: Identifiable {
    var id: String
    var product: Product
    var units: Int
    static let `default`  = Self(id: "String", product: Product.default, units: 1)
}

struct Cart {
    var items: [Item]
    var itemCount: Int
    var total: Double
    static let `default`  = Self(items: [], itemCount: 0, total: 0)
}
