//
//  AsyncImageBinder.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 24/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine
#if canImport(UIKit)
import UIKit
#endif

class SPDAsyncWebImageBinder: ObservableObject {
    private var subscription: AnyCancellable?
    
    private var cache = AsyncImageCache.shared
    
    #if canImport(UIKit)
    @Published private(set) var image: UIImage?
    #elseif canImport(AppKit)
    @Published private(set) var image: NSImage?
    #endif
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isFinished: Bool = false
    @Published private(set) var isCanceled: Bool = false
    
    func load(url: URL) {
        #if canImport(UIKit)
        if let image: UIImage = cache[url.absoluteString] {
            self.image = image
            return
        }
        #elseif canImport(AppKit)
        if let image: NSImage = cache[url.absoluteString] {
            self.image = image
            return
        }
        #endif
        
        subscription = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { _ in self.isLoading = true },
                          receiveOutput: { self.cache[url.absoluteString] = $0 },
                          receiveCompletion: { completion in self.isFinished = true },
                          receiveCancel: { self.isCanceled = true },
                          receiveRequest: { demand in })
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        subscription?.cancel()
    }
}


