//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 25/03/20.
//  Copyright © 2020 MoviesApp. All rights reserved.
//

import Foundation

class NetworkManager {
    enum RequestType: String {
        case get        = "GET"
        case post       = "POST"
        case put        = "PUT"
        case delete     = "DELETE"
    }
    
    private var networkLayer: NetworkLayer?
    
    var downloadQueue: OperationQueue = OperationQueue()
    
    init() {
        downloadQueue.maxConcurrentOperationCount = 10
    }
    
    public func make<Response: Decodable>(request: Encodable? = nil,
                                          url: URL,
                                          requestType: RequestType = .get,
                                          completionHandler: @escaping((Result<Response, Error>) -> Void)) {
        networkLayer = NetworkLayer(url: url, request: request, type: requestType.rawValue)
        self.networkLayer?.request(onResult: completionHandler)
    }
    
    public func downloadImage(url: URL, completionHandler: @escaping((Result<Data, Error>) -> Void)) {
        networkLayer = NetworkLayer(url: url, type: RequestType.get.rawValue)
        
        downloadQueue.addOperation {
            self.networkLayer?.downloadImage(completionHandler: completionHandler)
        }
    }
}
