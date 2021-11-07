//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Antonio Alves on 9/20/21.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
