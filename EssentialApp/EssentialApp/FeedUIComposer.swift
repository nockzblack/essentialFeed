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
        feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>,
        imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) -> ListViewController {
            
            let presentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>(loader: feedLoader)
            
            let feedController = makeFeedViewController(tittle: FeedPresenter.title)
            feedController.onRefresh = presentationAdapter.loadResource
            let presenter = LoadResourcePresenter(
                loadingView: WeakRefVirtualProxy(feedController),
                resourceView: FeedViewAdapter(
                    controller: feedController,
                    imageLoader: imageLoader),
                errorView: WeakRefVirtualProxy(feedController),
                mapper: FeedPresenter.map)
            
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
