//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Fernando Benavides on 01/06/25.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
