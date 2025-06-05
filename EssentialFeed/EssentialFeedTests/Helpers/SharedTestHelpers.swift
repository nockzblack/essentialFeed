//
//  SharedTestHelpers.swift
//  EssentialFeed
//
//  Created by Fernando Benavides on 05/06/25.
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}
