//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 03/01/26.
//

import Foundation

public protocol FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws
    func retrieve(dataForURL url: URL) throws -> Data?
}
