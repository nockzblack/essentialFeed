//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 22/09/25.
//

import Foundation

public final class FeedImagePresenter {
    
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
}
