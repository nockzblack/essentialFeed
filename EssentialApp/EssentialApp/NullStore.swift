//
//  NullStore.swift
//  EssentialApp
//
//  Created by Fernando Benavides on 26/05/26.
//

import Foundation
import EssentialFeed

final class NullStore: FeedStore & FeedImageDataStore {
    func deleteCacheFeed() throws {}
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {}
    
    func retrieve() throws -> CachedFeed? { .none }
    
    func insert(_ data: Data, for url: URL) throws {}
    
    func retrieve(dataForURL url: URL) throws -> Data? { .none }
}
