//
//  Product.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//
import FirebaseDatabase

struct Product: Identifiable {
    var productDict: [String: Any]
    var id: String
    var name: String
    var price: Double
    var imageURL: String
    var description: String
    var categoryName : String
    var images: [String]
    var isAvailable: Bool
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject] else {
            return nil
        }
        self.init(productDict: value)
    }
    
    init?(productDict: [String:Any]) {
        guard let name = productDict["name"] as? String,
            let id = productDict["id"] as? String
            else {
                return nil
            }
        self.productDict = productDict
        self.id = id
        self.name = name
        self.price = productDict["price"] as? Double ?? 0.0
        self.imageURL = productDict["image_url"] as? String ?? ""
        self.description = productDict["description"] as? String ?? ""
        self.categoryName = productDict["category_name"] as? String ?? ""
        self.images = productDict["images"] as? [String] ?? []
        self.isAvailable = productDict["isAvailable"] as? Bool ?? false
    }
}
