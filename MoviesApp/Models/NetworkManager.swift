//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 25/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import UIKit

class NetworkManager<Response: Decodable>: NSObject {
    typealias ServiceResult = ((Result<Response, Error>) -> Void)
    
    private var url: URL
    private var request: Encodable?
    private var requestType: RequestType
    
    init(url: URL, request: Encodable? = nil, type: RequestType) {
        self.url         = url
        self.request     = request
        self.requestType = type
    }
    
    enum RequestType: String {
        case get        = "GET"
        case post       = "POST"
        case put        = "PUT"
        case delete     = "DELETE"
    }
    
    private let sessionConfig: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 300.0
        sessionConfiguration.timeoutIntervalForResource = 300.0
        return sessionConfiguration
    }()
    
    
    /// getURLRequest
    ///
    /// - Returns: URLRequest instance
    /// - Throws: error while enoding request
    private func getURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.requestType.rawValue
        
        if let request = request {
            urlRequest.httpBody = try request.convertToData()
        }
        
        return urlRequest
    }
    
    
    /// Request
    ///
    /// - Parameters:
    ///   - onResult: onResult callback
    public func request(onResult: @escaping ServiceResult) {
        
        do {
            
            let session = URLSession(configuration: sessionConfig)
            session.dataTask(with: try getURLRequest()) { (data, urlResponse, error) in
                if let error = error {
                    onResult(.failure(error))
                    
                } else {
                    let httpUrlResponse: HTTPURLResponse = urlResponse as! HTTPURLResponse
                    if httpUrlResponse.statusCode == 200 {
                        guard let unwrappedData = data else { return }
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: unwrappedData)
                            onResult(.success(response))
                            
                        } catch let error {
                            onResult(.failure(error))
                        }
                        
                    } else {
                        print("status code : \(httpUrlResponse.statusCode)")
                    }
                }
            }.resume()
            session.finishTasksAndInvalidate()
            
        } catch let error {
            onResult(.failure(error))
            
        }
        
    }
}

fileprivate extension Encodable {
    func convertToData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
