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
    
    init(urlString: String, placeholder: Placeholder? = nil) {
        self.placeholder = placeholder

        loader = ImageLoader(urlString: urlString)
    
    }
    
    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}
