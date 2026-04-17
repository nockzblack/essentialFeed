//
//  CommentsUIComposer.swift
//  EssentialApp
//
//  Created by Fer Benavides Rodriguez on 17/04/26.
//

import UIKit
import Combine
import EssentialFeed
import EssentialFeediOS

public final class CommentsUIComposer {
    private init() {}
    
    public static func commentsComposedWith(
        commentsLoader: @escaping () -> AnyPublisher<[FeedImage], Error>) -> ListViewController {
            
            let presentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>(loader: commentsLoader)
            
            let feedController = makeFeedViewController(title: ImageCommentsPresenter.title)
            feedController.onRefresh = presentationAdapter.loadResource
            let presenter = LoadResourcePresenter(
                loadingView: WeakRefVirtualProxy(feedController),
                resourceView: FeedViewAdapter(
                    controller: feedController,
                    imageLoader: { _ in  Empty<Data, Error>().eraseToAnyPublisher() }),
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

