//
//  TestWebServiceHandler.swift
//  MoviesAppTests
//
//  Created by SAMBIT DASH on 12/11/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import XCTest
@testable import MoviesApp

class TestWebServiceHandler: XCTestCase {
    var webServiceHandler: WebServiceHandler?
    
    override func setUp() {
        webServiceHandler = WebServiceHandler()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchPopularMovies() {
        let popularMoviesExpectation = XCTestExpectation(description: "Download apple.com home page")
        webServiceHandler?.fetchPopularMovies(complitionHandler: { (result) in
            switch result {
                
            case .success(let response):
                XCTAssertNotNil(response, "Response is not nil")
                popularMoviesExpectation.fulfill()
                break
            case .failure(_):
                break
            }
        })
        wait(for: [popularMoviesExpectation], timeout: 10.0)
    }

}
