//
//  RemoteFeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 24/12/25.
//

import XCTest
import EssentialFeed

final class RemoteFeedImageDataLoader {
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success:
                completion(.failure(Error.invalidData))
            case let .failure(error):
                completion(.failure(error))
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
    
    // `RemoteFeedImageDataLoader.loadImageDataFromURL` delivers invalid data error on non-200 HTTP response
    
    func test_loadImgaeDataFromURL_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        let exp = expectation(description: "Wait for load completion")
        let url = URL(string: "https://a-given-url.com")!
        let expectedResult: FeedImageDataLoader.Result =  .failure(RemoteFeedImageDataLoader.Error.invalidData)
        
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
        
        client.complete(withStatusCode: 201, data: anyData())
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: RemoteFeedImageDataLoader, spy: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedImageDataLoader(client: client)
        
        return (sut, client)
    }
    
    private func anyData() -> Data {
        return Data("any data".utf8)
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
        
        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            
            messages[index].completion(.success((data, response)))
        }
    }
}
