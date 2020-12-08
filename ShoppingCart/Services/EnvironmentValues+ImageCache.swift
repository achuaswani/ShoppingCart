//
//  EnvironmentValues+ImageCache.swift
//  ShoppingCart
//
//  Created by Aswani G on 8/29/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
