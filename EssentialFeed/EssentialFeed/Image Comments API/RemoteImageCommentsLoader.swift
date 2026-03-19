//
//  RemoteImageCommentsLoader.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 10/03/26.
//

import Foundation

public typealias RemoteImageCommentsLoader = RemoteLoader<[ImageComment]>

public extension RemoteImageCommentsLoader {
    convenience init(client: HTTPClient, url: URL) {
        self.init(client: client, url: url, mapper: ImagesCommentsMapper.map)
    }
}
