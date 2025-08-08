//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeed
//
//  Created by Fernando Benavides on 27/04/25.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ isntance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak isntance] in
            XCTAssertNil(isntance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
