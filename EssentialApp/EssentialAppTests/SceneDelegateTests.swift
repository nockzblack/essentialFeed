//
//  SceneDelegateTests.swift
//  EssentialApp
//
//  Created by Fer Benavides Rodriguez on 21/01/26.
//

import XCTest
import EssentialFeediOS
@testable import EssentialApp

class SceneDelegateTests: XCTestCase {
    
    func test_sceneWillConnectToSession_configuresRootViewController() {
        let sut = SceneDelegate()
        let window = (UIApplication.shared.connectedScenes.first as! UIWindowScene).windows.first
        sut.window = window
        
        sut.configureWindow()
        
        let root = sut.window?.rootViewController
        let rootNavigation = root as? UINavigationController
        let topViewController = rootNavigation?.topViewController
        
        XCTAssertNotNil(rootNavigation, "Expected a navigation controller as root, got \(String(describing: root)) instead")
        XCTAssertTrue(topViewController is FeedViewController, "Expected a feed controller as top view controller, got \(String(describing: topViewController)) instead")
    }
}
