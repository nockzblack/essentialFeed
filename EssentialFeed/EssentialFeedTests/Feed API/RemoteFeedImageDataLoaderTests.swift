//
//  RemoteFeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 24/12/25.
//

import XCTest
import EssentialFeed

final class RemoteFeedImageDataLoader {
    
    init(client: Any) {
        
    }
}

final class RemoteFeedImageDataLoaderTests: XCTestCase {
    
    func test_init_doesNotPerfromAnyURLRequest() {
        let client = HTTPClientSpy()
        let _ = RemoteFeedImageDataLoader(client: client)
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    private class HTTPClientSpy {
        var requestedURLs = [URL]()
    }
}
