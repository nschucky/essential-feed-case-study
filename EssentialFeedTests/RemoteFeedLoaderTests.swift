//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Antonio Alves on 10/5/21.
//

import XCTest
import EssentialFeed
import Foundation

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssert(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://an-url.com")!
        let (sut, client) = makeSUT(with: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_requestsDataFromURLTwice() {
        let url = URL(string: "https://an-url.com")!
        let (sut, client) = makeSUT(with: url)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let url = URL(string: "https://an-url.com")!
        let (sut, client) = makeSUT(with: url)
        
        var capturedError = [RemoteFeedLoader.Error]()
        sut.load { error in
            capturedError.append(error)
        }
        
        let clientError = NSError(domain: "Testing", code: 1)
        client.completions[0](clientError)
        
        XCTAssertEqual(capturedError, [.connectivity])
    }
    
    // MARK: Helpers
    
    private func makeSUT(with url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let loader = RemoteFeedLoader(url: url,client: client)
        return (loader, client)
    }

    private class HTTPClientSpy: HTTPClient {
        var requestedURLs: [URL] = []
        var completions: [((Error) -> Void)] = []
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            requestedURLs.append(url)
            completions.append(completion)
        }
    }
}
