//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 22/09/25.
//

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        return location != nil
    }
}
