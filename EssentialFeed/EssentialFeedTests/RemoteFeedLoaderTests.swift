//
//  RemoteFeedLoaderTests.swift
//  EssentialFeed
//
//  Created by Fernando Benavides on 11/03/25.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTest {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoaderTests()
        
        XCTAssertNil(client.requestedURL)
    }
    
    
}
