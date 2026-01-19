//
//  AppDelegate.swift
//  EssentialApp
//
//  Created by Fer Benavides Rodriguez on 05/01/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configurarion", sessionRole: connectingSceneSession.role)
        
        #if DEBUG
        configuration.delegateClass =  DebuggingSceneDelegate.self
        #endif
        
        return configuration
    }
}

