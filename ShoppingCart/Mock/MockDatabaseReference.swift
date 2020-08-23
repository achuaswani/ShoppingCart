//
//  MockDatabaseReference.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/27/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation
import FirebaseDatabase

class MockDatabaseReference: DatabaseReference {

    override func child(_ pathString: String) -> DatabaseReference {
        return self
    }

    override func observeSingleEvent(of eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void) {
        let snapshot = MockSnapshot()
        DispatchQueue.global().async {
            block(snapshot)
        }
    }
}

class MockSnapshot: DataSnapshot {

    override var value: Any? {
       if let path = Bundle.main.path(forResource: "MockProducts", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let products = jsonResult["products"] as? [Any] {
                    return products
                  }
              } catch {
                  
              }
        }
        return []
    }
}
