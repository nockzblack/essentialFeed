//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Fernando Benavides on 06/06/25.
//

import Foundation

internal final class FeedCachePolicy {
    private init() {}
    
    static private let calendar = Calendar(identifier: .gregorian)
    
    static private var maxCacheAgeInDays: Int {
        return 7
    }
    
    static func validate(_ timestamp: Date, against currentDate: Date) -> Bool {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        return currentDate < maxCacheAge
    }
}
