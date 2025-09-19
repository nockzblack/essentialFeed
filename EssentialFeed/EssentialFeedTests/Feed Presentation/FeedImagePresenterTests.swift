//
//  FeedImagePresenter.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 19/09/25.
//

import XCTest
import EssentialFeed

final class FeedImagePresenter {
    
}

final class FeedImagePresenterTests: XCTestCase {
    
    func test_init_doesNotSendMessageToView() {
        let view = AnyFeedImageView()
        _ = FeedImagePresenter()
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }

    
    // MARK: - Helpers
    
    final class AnyFeedImageView {
        enum Message {}
        let messages = [Message]()
    }
}
