//
//  FeedLoaderCacheDecoratorTests.swift
//  EssentialApp
//
//  Created by Fer Benavides Rodriguez on 13/01/26.
//

import XCTest
import EssentialFeed

class FeedLoaderCacheDecorator: FeedLoader {
    private let decoratee: FeedLoader
    
    init(decoratee: FeedLoader) {
        self.decoratee = decoratee
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load(completion: completion)
    }
}

final class FeedLoaderCacheDecoratorTests: XCTestCase, FeedLoaderTestCase {
    
    func test_load_deliversFeedOnLoaderSucces() {
        let feed = uniqueFeed()
        let loader = FeeedLoaderStub(result: .success(feed))
        let sut = FeedLoaderCacheDecorator(decoratee: loader)
        
        expect(sut, toCompleteWith: .success(feed))
    }
    
    func test_load_deliversErrorOnLoaderFailure() {
        let loader = FeeedLoaderStub(result: .failure(anyNSError()))
        let sut = FeedLoaderCacheDecorator(decoratee: loader)
        
        expect(sut, toCompleteWith: .failure(anyNSError()))
    }
}
