//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 13/01/26.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}
