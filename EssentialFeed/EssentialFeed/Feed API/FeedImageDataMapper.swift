//
//  FeedImageDataMapper.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 06/05/26.
//

import Foundation

public class FeedImageDataMapper {
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
        guard response.isOK, !data.isEmpty else {
            throw Error.invalidData
        }
        
        return data
    }
}
