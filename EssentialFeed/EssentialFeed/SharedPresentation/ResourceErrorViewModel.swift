//
//  ResourceErrorViewModel.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 18/09/25.
//

public struct ResourceErrorViewModel {
    public let message: String?
    
    public static var noError: ResourceErrorViewModel {
        return ResourceErrorViewModel(message: nil)
    }
    
    public static func error(message: String) -> ResourceErrorViewModel {
        return ResourceErrorViewModel(message: message)
    }
}
