//
//  FeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 28/08/25.
//

import Foundation

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
