//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Fernando Benavides on 03/04/25.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
