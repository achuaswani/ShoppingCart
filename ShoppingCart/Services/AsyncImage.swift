//
//  AsyncImage.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/28/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    private let configuration: (Image) -> Image
    init(urlString: String, placeholder: Placeholder? = nil,  cache: ImageCache? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
        self.placeholder = placeholder
        loader = ImageLoader(urlString: urlString, cache: cache)
        self.configuration = configuration
    }
    
    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image: some View {
        Group {
            if loader.image != nil {
                configuration(Image(uiImage: loader.image!))
            } else {
                placeholder
            }
        }
    }
}
