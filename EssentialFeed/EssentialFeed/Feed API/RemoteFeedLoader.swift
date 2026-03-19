//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Fernando Benavides on 12/03/25.
//

import Foundation

public typealias RemoteFeedLoader = RemoteLoader<[FeedImage]>

public extension RemoteFeedLoader {
    convenience init(client: HTTPClient, url: URL) {
        self.init(client: client, url: url, mapper: FeedItemsMapper.map)
    }
}
