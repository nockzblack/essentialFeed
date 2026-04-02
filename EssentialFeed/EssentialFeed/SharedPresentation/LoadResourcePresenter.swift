//
//  LoadResourcePresenter.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 02/04/26.
//

import Foundation

public protocol ResourceView {
    associatedtype ResourceViewModel
    
    func display(_ viewModel: ResourceViewModel)
}

public final class LoadResourcePresenter<Resource, View: ResourceView> {
    public typealias Mapper = (Resource) -> View.ResourceViewModel
    
    private let loadingView: FeedLoadingView
    private let resourceView: View
    private let errorView: FeedErrorView
    private let mapper: Mapper
    
    public init(loadingView: FeedLoadingView, feedView: View, errorView: FeedErrorView, mapper: @escaping Mapper) {
        self.loadingView = loadingView
        self.resourceView = feedView
        self.errorView = errorView
        self.mapper = mapper
    }
    
    public static var loadError: String {
        return NSLocalizedString(
            "GENERIC_CONNECTION_ERROR",
            tableName: "Shared",
            bundle: Bundle(for: Self.self),
            comment: "Error message displayed when we can't load the resource from the server")
    }
    
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with resource: Resource) {
        loadingView.display(FeedLoadingViewModel(isLoading: false))
        resourceView.display(mapper(resource))
    }
    
    public func didFinishLoading(with error: Error) {
        errorView.display(.error(message: Self.loadError))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
