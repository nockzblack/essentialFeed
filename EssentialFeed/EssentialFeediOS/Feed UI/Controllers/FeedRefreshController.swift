//
//  FeedRefreshController.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 28/08/25.
//

import UIKit

protocol FeedRefreshControllerDelegate {
    func didRequestFeedRefresh()
}

public final class FeedRefreshViewController: NSObject, FeedLoadingView {
    public lazy var view = loadView()
    
    private let delegate: FeedRefreshControllerDelegate
    
    init(delegate: FeedRefreshControllerDelegate) {
        self.delegate = delegate
    }
    
    @objc func refresh() {
        delegate.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
