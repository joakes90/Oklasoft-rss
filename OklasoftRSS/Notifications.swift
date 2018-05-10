//
//  Notifications.swift
//  OklasoftRSS
//
//  Created by Justin Oakes on 7/2/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import Foundation

public let feedInfoKey = "feed"
public let storyInfoKey = "story"
public extension Notification.Name {
    static let finishedReceavingFeed = Notification.Name("finishedReceavingFeed")
    static let foundFeedURLs = Notification.Name("foundFeedURLs")
    static let foundFavIcon = Notification.Name("foundFavIcon")
    static let finishedFindingStories = Notification.Name("finishedFindingStories")
    static let feedIdentificationError = Notification.Name("notificationError")
    static let errorFindingStories = Notification.Name("errorFindingStories")
    static let errorConvertingHTML = Notification.Name("errorConvertingHTML")
}
