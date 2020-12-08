//
//  CustomCorner.swift
//  ShoppingCart
//
//  Created by Aswani G on 8/23/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct CustomCorner : Shape {
    
    var corners : UIRectCorner
    var size : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}
