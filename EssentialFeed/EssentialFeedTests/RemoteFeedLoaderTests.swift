//
//  RemoteFeedLoaderTests.swift
//  EssentialFeed
//
//  Created by Fernando Benavides on 11/03/25.
//

import XCTest

class RemoteFeedLoader {
    
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    
    private init() {}
    
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTest {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoaderTests()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestedDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
    
    
}
