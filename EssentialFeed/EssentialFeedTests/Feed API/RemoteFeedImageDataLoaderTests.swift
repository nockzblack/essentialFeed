//
//  RemoteFeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 24/12/25.
//

import XCTest
import EssentialFeed

final class RemoteFeedImageDataLoader {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            default: break
            }
        }
    }
}

final class RemoteFeedImageDataLoaderTests: XCTestCase {
    
    func test_init_doesNotPerfromAnyURLRequest() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_loadImageDataFromURL_requestDataFromURL() {
        let (sut, client) = makeSUT()
        let url = URL(string: "https://a-given-url.com")!
        
        sut.loadImageData(from: url) { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadImageDataFromURL_requestDataFromURLTwice() {
        let (sut, client) = makeSUT()
        let url = URL(string: "https://a-given-url.com")!
        
        sut.loadImageData(from: url) { _ in }
        sut.loadImageData(from: url) { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_loadImageDataFromURL_deliverErrorOnClientError() {
        let (sut, client) = makeSUT()
        let url = URL(string: "https://a-given-url.com")!
        let clientError = NSError(domain: "a client error", code: 0)
        let exp = expectation(description: "Wait for load completion")
        let expectedResult: FeedImageDataLoader.Result =  .failure(clientError)
        
        sut.loadImageData(from: url) { receivedResult in
            switch(expectedResult, receivedResult) {
            
            case let (.success(expectedData), .success(receivedData)):
                XCTAssertEqual(expectedData, receivedData)
                
            case let (.failure(reivedError as NSError), .failure(expectedError as NSError)):
                XCTAssertEqual(reivedError, expectedError)
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead")
            }
            
            exp.fulfill()
        }
        
        client.complete(with: clientError)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: RemoteFeedImageDataLoader, spy: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedImageDataLoader(client: client)
        
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()
        
        var requestedURLs: [URL] {
            messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
    }
}
