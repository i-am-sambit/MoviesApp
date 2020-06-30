//
//  AsyncImageCache.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 26/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

class AsyncImageCache {
    static let shared = AsyncImageCache()
    
    #if canImport(UIKit)
    private var cache: NSCache = NSCache<NSString, UIImage>()
    #elseif canImport(AppKit)
    private var cache: NSCache = NSCache<NSString, NSImage>()
    #endif
    
    #if canImport(UIKit)
    subscript(key: String) -> UIImage? {
        get { cache.object(forKey: key as NSString) }
        set(image) { image == nil ? self.cache.removeObject(forKey: (key as NSString)) : self.cache.setObject(image!, forKey: (key as NSString)) }
    }
    #elseif canImport(AppKit)
    subscript(key: String) -> NSImage? {
        get { cache.object(forKey: key as NSString) }
        set(image) { image == nil ? self.cache.removeObject(forKey: (key as NSString)) : self.cache.setObject(image!, forKey: (key as NSString)) }
    }
    #endif
    
}
