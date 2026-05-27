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
    
    private typealias FeedPresentationAdapter = LoadResourcePresentationAdapter<Paginated<FeedImage>, FeedViewAdapter>
    
    public static func feedComposedWith(
        feedLoader: @escaping () -> AnyPublisher<Paginated<FeedImage>, Error>,
        imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher,
        selection: @escaping (FeedImage) -> Void = { _ in }) -> ListViewController {
            
            let presentationAdapter = FeedPresentationAdapter(loader: feedLoader)
            
            let feedController = makeFeedViewController(title: FeedPresenter.title)
            feedController.onRefresh = presentationAdapter.loadResource
            
            let presenter = LoadResourcePresenter(
                loadingView: WeakRefVirtualProxy(feedController),
                resourceView: FeedViewAdapter(
                    controller: feedController,
                    imageLoader: imageLoader,
                    selection: selection),
                errorView: WeakRefVirtualProxy(feedController),
                mapper: { $0 })
            
            presentationAdapter.presenter = presenter
            
            return feedController
        }
    
    private static func makeFeedViewController(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! ListViewController
        feedController.title = title
        
        return feedController
    }
}
