//
//  LoadResourcePresenter.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 02/04/26.
//

import Foundation

public protocol ResourceView {
    func display(_ viewModel: String)
}

public final class LoadResourcePresenter {
    public typealias Mapper = (String) -> String
    
    private let loadingView: FeedLoadingView
    private let resourceView: ResourceView
    private let errorView: FeedErrorView
    private let mapper: Mapper
    
    public init(loadingView: FeedLoadingView, feedView: ResourceView, errorView: FeedErrorView, mapper: @escaping Mapper) {
        self.loadingView = loadingView
        self.resourceView = feedView
        self.errorView = errorView
        self.mapper = mapper
    }
    
    private var feedLoadError: String {
        return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR", tableName: "Feed", bundle: Bundle(for: FeedPresenter.self), comment: "Error message displayed when we can't load the image feed from the server")
    }
    
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with resource: String) {
        loadingView.display(FeedLoadingViewModel(isLoading: false))
        resourceView.display(mapper(resource))
    }
    
    public func didFinishLoadingFeed(with error: Error) {
        errorView.display(.error(message: feedLoadError))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
