//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 02/09/25.
//

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
