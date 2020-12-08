//
//  Product.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//
import FirebaseDatabase

struct Products: Codable {
    var products: [Product]
    static let `default`  = Self(products: [Product.default])
}
struct Product: Codable, Identifiable {
    var id: String
    var name: String
    var price: Double
    var image_url: String
    var description: String
    var category_name : String
    var images: [String]
    //var isAvailable: Bool
    static let `default`  = Self(id: "String",
                                 name: "Name ",
                                 price: 1.2,
                                 image_url: "String",
                                 description: "String",
                                 category_name: "Category",
                                 images: ["String"]
                                 //isAvailable: false
                                )
}
