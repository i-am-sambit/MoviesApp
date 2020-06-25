//
//  AsyncImageBinder.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 24/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine
import UIKit

class AsyncImageBinder: ObservableObject {
    var objectWillChange: ObservableObjectPublisher = ObjectWillChangePublisher()
    private var subscription: AnyCancellable?
    
    private(set) var image: UIImage? {
        didSet {
            objectWillChange.send()
        }
    }
    
    private var cache = AsyncCache.shared
    
    func load(url: URL) {
        if let image: UIImage = cache[url.absoluteString] {
            self.image = image
        }
        
        subscription = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { self.cache[url.absoluteString] = $0 })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        subscription?.cancel()
    }
}


class AsyncCache {
    static let shared = AsyncCache()
    
    private var cache: NSCache = NSCache<NSString, UIImage>()
    
    subscript(key: String) -> UIImage? {
        get { cache.object(forKey: key as NSString) }
        set(image) { image == nil ? self.cache.removeObject(forKey: (key as NSString)) : self.cache.setObject(image!, forKey: (key as NSString)) }
    }
}
