//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 13/01/26.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}
