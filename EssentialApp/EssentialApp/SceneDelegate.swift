//
//  SceneDelegate.swift
//  EssentialApp
//
//  Created by Fer Benavides Rodriguez on 05/01/26.
//

import UIKit
import CoreData
import EssentialFeed
import EssentialFeediOS
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session:  URLSession(configuration: .ephemeral))
    }()
    
    private lazy var store: FeedStore & FeedImageDataStore = {
        try! CoreDataFeedStore(storeURL: NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathComponent("feed-store.sqlite"))
    }()
    
    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store, currentDate: Date.init)
    }()
    
    private lazy var baseURL = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1")!
    
    private lazy var navigationController = UINavigationController(rootViewController: FeedUIComposer.feedComposedWith(
        feedLoader: makeRemoteFeedLoaderWithLocalFallback,
        imageLoader: makeLocalImageLoaderWithRemoteFallback,
        selection: showComments))
    
    convenience init(httpClient: HTTPClient, store: FeedStore & FeedImageDataStore) {
        self.init()
        self.httpClient = httpClient
        self.store = store
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKey()
        window?.makeKeyAndVisible()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        localFeedLoader.validateCache { _ in }
    }
    
    private func showComments(for image: FeedImage) {
        let remoteURL = baseURL.appendingPathComponent("/image/\(image.id)/comments")
        let comments = CommentsUIComposer.commentsComposedWith(commentsLoader: makeRemoteCommentsLoader(url: remoteURL))
        navigationController.pushViewController(comments, animated: true)
    }
    
    private func makeRemoteCommentsLoader(url: URL) -> () -> AnyPublisher<[ImageComment], Error>  {
        return { [httpClient] in
            return httpClient
                .getPublisher(url: url)
                .tryMap(ImagesCommentsMapper.map)
                .eraseToAnyPublisher()
        }
    }
    
    private func makeRemoteFeedLoaderWithLocalFallback() -> AnyPublisher<[FeedImage], Error> {
        let remoteURL = baseURL.appendingPathComponent("feed")
        
        return httpClient
            .getPublisher(url: remoteURL)
            .tryMap(FeedItemsMapper.map)
            .caching(to: localFeedLoader)
            .fallback(to: localFeedLoader.loadPublisher)
    }
    
    private func makeLocalImageLoaderWithRemoteFallback(url: URL) -> FeedImageDataLoader.Publisher {
        let remoteImageLoader = RemoteFeedImageDataLoader(client: httpClient)
        let localImageLoader = LocalFeedImageDataLoader(store: store)
        
        return localImageLoader.loadImageDataPublisher(from: url)
            .fallback {
                remoteImageLoader
                    .loadImageDataPublisher(from: url)
                    .caching(to: localImageLoader, using: url)
            }
    }
}
