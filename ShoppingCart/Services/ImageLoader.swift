//
//  ImageLoader.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/28/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?
    private var cache: ImageCache?
    private(set) var isLoading = false
    init(urlString: String, cache: ImageCache? = nil) {
        self.url = URL(string: urlString)
        self.cache = cache
        //self.url = URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!
    }
    private var cancellable: AnyCancellable?
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    deinit {
        cancellable?.cancel()
    }

    func load() {
        guard !isLoading else { return }
        guard let url = url else {
            cancellable?.cancel()
            return
        }
        
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.imageProcessingQueue)
            .map {
                UIImage(data: $0.data)
            }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] in self?.cache($0) })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    private func cache(_ image: UIImage?) {
        guard let url = url else { return }
        image.map { cache?[url] = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func onStart() {
       isLoading = true
   }
   
   private func onFinish() {
       isLoading = false
   }
}
