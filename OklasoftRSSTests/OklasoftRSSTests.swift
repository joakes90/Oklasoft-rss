//
//  OklasoftRSSTests.swift
//  OklasoftRSSTests
//
//  Created by Justin Oakes on 7/1/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import XCTest
@testable import OklasoftRSS
import OklasoftNetworking

class OklasoftRSSTests: XCTestCase {
    
    //where test objects will be stored and evaluated against
    var testFeeds: [Feed] = []
    
    //Test params
//RSS test 1
//    let rssURL: URL = URL(string:"http://feeds.macrumors.com/MacRumors-All")!
//RSS test 2
    let rssURL = URL(string:"http://inessential.com/xml/rss.xml")!
    
//Atom test 1
    let atomURL: URL = URL(string:"https://daringfireball.net/feeds/main")!
//Atom test 2
//    let atomURL: URL = URL(string: "http://blog.atom.io/feed.xml")!
    
// Podcast test 1
//    let audioPodcastTest: URL = URL(string: "http://atp.fm/episodes?format=rss")!
// Podcast test 2
    let audioPodcastTest: URL = URL(string: "http://feeds.feedburner.com/PhoneDifferentPodcast")!

// HTML test1
    let htmlURL: URL = URL(string: "http://www.npr.org")!
    
    override func setUp() {
        super.setUp()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(testReceaveFeed(aNotification:)),
                                               name: .finishedReceavingFeed,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(testFavIcon(aNotification:)),
                                               name: .foundFavIcon,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(testReceaveStories(aNotification:)),
                                               name: .finishedFindingStories,
                                               object: nil)
    }
    
    override func tearDown() {
        super.tearDown()
        NotificationCenter.default.removeObserver(self)
    }
    
    // RSS Testing
    func testRSSIdent() {
        URLSession.shared.getReturnedDataFrom(url: rssURL, with: URLSession.identifyFeedsCompletion)
        let expectation: XCTNSNotificationExpectation = XCTNSNotificationExpectation(name: .finishedReceavingFeed)
        let favIconExpect: XCTNSNotificationExpectation = XCTNSNotificationExpectation(name: .foundFavIcon)
        let storiesExpect:XCTNSNotificationExpectation = XCTNSNotificationExpectation(name: .finishedFindingStories)
        self.wait(for: [expectation, favIconExpect, storiesExpect], timeout: 10)
    }
    
    // Atom Testing
    func testAtomIdent() {
        URLSession.shared.getReturnedDataFrom(url: atomURL, with: URLSession.identifyFeedsCompletion)
        let expectation: XCTNSNotificationExpectation = XCTNSNotificationExpectation(name: .finishedReceavingFeed)
        let favIconExpect: XCTNSNotificationExpectation = XCTNSNotificationExpectation(name: .foundFavIcon)
        let storiesExpect:XCTNSNotificationExpectation = XCTNSNotificationExpectation(name: .finishedFindingStories)
        self.wait(for: [expectation, favIconExpect, storiesExpect], timeout: 10)
    }
    
    // RSS Podcast Testing
    func testPodcastIdent() {
        URLSession.shared.getReturnedDataFrom(url: audioPodcastTest, with: URLSession.identifyFeedsCompletion)
        let expectation: XCTNSNotificationExpectation = XCTNSNotificationExpectation(name: .finishedReceavingFeed)
        let storiesExpect:XCTNSNotificationExpectation = XCTNSNotificationExpectation(name: .finishedFindingStories)
        self.wait(for: [expectation, storiesExpect], timeout: 10)
    }
    
    func testHTML() {
        URLSession.shared.getReturnedDataFrom(url: htmlURL, with: URLSession.findFeedsCompletion)
        let expectation: XCTNSNotificationExpectation = XCTNSNotificationExpectation(name: .foundFeedURLs)
        self.wait(for: [expectation], timeout: 10)
    }
    
    @objc func testReceaveFeed(aNotification: Notification) {
        guard let userInfo: [AnyHashable:Any] = aNotification.userInfo,
            let newFeed: Feed = userInfo[feedInfoKey] as? Feed
            else {
                XCTFail()
                return
        }
        testFeeds.append(newFeed)
        XCTAssertNotNil(testFeeds[0])
    }
    
    @objc func testFavIcon(aNotification: Notification) {
        guard let userInfo: [AnyHashable:Any] = aNotification.userInfo,
            let keyURL: URL = userInfo.keys.first as? URL,
            let imageURL: URL = userInfo[keyURL] as? URL
            else {
                return
        }
        XCTAssertNotNil(imageURL)
    }
    
    @objc func testReceaveStories(aNotification: Notification) {
        guard let userInfo: [AnyHashable:Any] = aNotification.userInfo,
            let stories: [Story] = userInfo[testFeeds[0].url] as? [Story]
            else {
                XCTFail()
                return
        }
        XCTAssertGreaterThan(stories.count, 1, "Notification for new stories called but array was empty")
    }
    
}

