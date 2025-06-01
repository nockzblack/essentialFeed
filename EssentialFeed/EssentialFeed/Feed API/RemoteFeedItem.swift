//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Fernando Benavides on 01/06/25.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
