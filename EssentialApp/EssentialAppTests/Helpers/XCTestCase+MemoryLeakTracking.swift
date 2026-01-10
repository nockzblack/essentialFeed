//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialApp
//
//  Created by Fer Benavides Rodriguez on 10/01/26.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ isntance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak isntance] in
            XCTAssertNil(isntance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
