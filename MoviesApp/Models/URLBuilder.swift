//
//  URLBuilder.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 09/11/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

class URLBuilder {
    private var components: URLComponents = URLComponents()
    
    init(scheme: String, host: String) {
        self.components.scheme = scheme
        self.components.host = host
    }
    
    func set(port: Int) -> URLBuilder {
        self.components.port = port
        return self
    }
    
    func set(path: String) -> URLBuilder {
        var path = path
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        self.components.path = path
        return self
    }
    
    func addQueryItem<Element>(name: String, value: Element) -> URLBuilder  {
        if self.components.queryItems == nil {
            self.components.queryItems = []
        }
        self.components.queryItems?.append(URLQueryItem(name: name, value: "\(value)"))
        return self
    }
    
    func set(query: String) -> URLBuilder {
//        self.components.port = port
        return self
    }
    
    func set(opertion: String) -> URLBuilder {
//        self.components.port = port
        return self
    }
    
    @discardableResult func build() -> URL? {
        return self.components.url
    }
}
