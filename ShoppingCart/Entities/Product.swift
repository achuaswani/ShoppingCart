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
    var imageURL: String
    var description: String
    var categoryName : String
    var images: [String]
    var productType: [String]
    var selectedType: String
    var isAvailable: Bool
    static let `default`  = Self(id: "String",
                                 name: "Name",
                                 price: 1.2,
                                 imageURL: "String",
                                 description: "String",
                                 categoryName: "Category",
                                 images: ["String"],
                                 productType: ["Color"],
                                 selectedType: "White",
                                 isAvailable: true
                                )
}
