//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Antonio Alves on 9/20/21.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
