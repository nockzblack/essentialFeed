//
//  UIRefreshControl+Helpers.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 18/09/25.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ?  beginRefreshing() : endRefreshing()
    }
}
