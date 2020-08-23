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
}

struct Cart {
    var items: [Item]
    var itemCount: Int
    var total: Double
}
