//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Antonio Alves on 9/20/21.
//

import Foundation

protocol FeedLoader {
    func load(completion: @escaping (Result<[FeedItem], Error>) -> Void)
}
