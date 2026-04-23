//
//  ImageCommentsEndpoint.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 21/04/26.
//

import Foundation

public enum ImageCommentsEndpoint {
    case get(UUID)
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case .get(let id):
            return baseURL.appendingPathComponent("/v1/image/\(id)/comments")
        }
    }
}
