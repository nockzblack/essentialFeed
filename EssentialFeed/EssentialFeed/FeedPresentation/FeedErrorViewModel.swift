//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 18/09/25.
//

public struct FeedErrorViewModel {
    public let message: String?
    
    public static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    public static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
