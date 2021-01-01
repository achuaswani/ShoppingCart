//
//  View+Extension.swift
//  ShoppingCart
//
//  Created by Aswani G on 1/1/21.
//  Copyright © 2021 pixycoders private limited. All rights reserved.
//

import SwiftUI

extension View {
    func debugPrint(_ value: Any) -> some View {
        #if DEBUG
        print(value)
        #endif
        return self
    }
}
