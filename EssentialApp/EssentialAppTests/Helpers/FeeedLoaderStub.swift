//
//  FeeedLoaderStub.swift
//  EssentialApp
//
//  Created by Fer Benavides Rodriguez on 13/01/26.
//

import EssentialFeed

final class FeeedLoaderStub: FeedLoader {
    private let result: FeedLoader.Result
    
    init(result: FeedLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        completion(result)
    }
}
