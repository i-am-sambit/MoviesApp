//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 25/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import UIKit

class NetworkManager: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    private var url: URL
    private var request: Encodable?
    private var requestType: RequestType
    
    private let imageCache: NSCache = NSCache<NSURL, NSData>()
    
    init(url: URL, request: Encodable? = nil, type: RequestType = .get) {
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
    
    private var defaultSessionConfig: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 300.0
        config.timeoutIntervalForResource = 300.0
        config.allowsCellularAccess = true
        return config
    }
    
    private var downloadSessionConfig: URLSessionConfiguration {
        let config = URLSessionConfiguration.background(withIdentifier: "")
        return config
    }
    
    
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
    public func request<Response: Decodable>(onResult: @escaping((Result<Response, Error>) -> Void)) {
        
        do {
            
            let session = URLSession(configuration: defaultSessionConfig)
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
    
    public func downloadImage(completionHandler: @escaping((Result<Data, Error>) -> Void)) {
        if let cachedData: Data = imageCache.object(forKey: self.url as NSURL) as Data? {
            completionHandler(.success(cachedData))
        }
        
        URLSession.shared.dataTask(with: url) { (data, httpResponse, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            if let data = data {
                if let url: NSURL = httpResponse?.url as NSURL? {
                    self.imageCache.setObject(data as NSData, forKey: url)
                }
                completionHandler(.success(data))
            } else {
                
            }
        }.resume()
    }
    
    func upload() {
        let session = URLSession(configuration: defaultSessionConfig,
                                 delegate: self,
                                 delegateQueue: .main)
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willBeginDelayedRequest request: URLRequest, completionHandler: @escaping (URLSession.DelayedRequestDisposition, URLRequest?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        
    }
}

fileprivate extension Encodable {
    func convertToData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
