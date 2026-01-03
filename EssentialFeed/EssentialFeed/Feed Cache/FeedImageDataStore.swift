//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 03/01/26.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    
    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
