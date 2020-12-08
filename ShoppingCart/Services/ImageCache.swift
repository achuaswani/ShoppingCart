//
//  ImageCache.swift
//  ShoppingCart
//
//  Created by Aswani G on 8/29/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI
import Combine

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
