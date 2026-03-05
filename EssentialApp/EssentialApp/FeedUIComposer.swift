//
//  FeedUIComposer.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 28/08/25.
//

import UIKit
import Combine
import EssentialFeed
import EssentialFeediOS

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(
        feedLoader: @escaping () -> FeedLoader.Publisher,
        imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) -> FeedViewController {
        
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: feedLoader)
        
        let feedController = makeFeedViewController(delegate: presentationAdapter, tittle: FeedPresenter.title)
        
        let presenter = FeedPresenter(
            loadingView: WeakRefVirtualProxy(feedController),
            feedView: FeedViewAdapter(
                controller: feedController,
                imageLoader: imageLoader),
            errorView: WeakRefVirtualProxy(feedController))
        
        presentationAdapter.presenter = presenter
        
        return feedController
    }
    
    private static func makeFeedViewController(delegate: FeedViewControllerDelegate, tittle: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
        feedController.delegate = delegate
        feedController.title = FeedPresenter.title
        
        return feedController
    }
}
