//
//  CoreDataFeedStore+FeedStore.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 04/01/26.
//

import CoreData

extension CoreDataFeedStore: FeedStore {
    
    public func retrieve() throws -> CachedFeed? {
        try ManagedCache.find(in: context).map {
            CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
        }
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {
        let managedCache = try ManagedCache.newUniqueInstance(in: context)
        managedCache.timestamp = timestamp
        managedCache.feed = ManagedFeedImage.images(from: feed, in: context)
        try context.save()
    }
    
    public func deleteCacheFeed() throws {
        try ManagedCache.deleteCache(in: context)
    }
}
