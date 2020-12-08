//
//  Localizations.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation

extension String {
    public func localized(withValue value: String = "") -> String {
       return String(format: NSLocalizedString(self, comment: "" ), value)
   }
}
