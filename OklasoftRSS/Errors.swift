//
//  Errors.swift
//  OklasoftRSS
//
//  Created by Justin Oakes on 7/5/17.
//  Copyright © 2017 Oklasoft LLC. All rights reserved.
//

import Foundation
#if os(OSX)
    import OklasoftError
#elseif os(iOS)
    import OklasoftError_iOS_
#endif

public let couldnotFindUserInfo: oklasoftError = oklasoftError(errorCode: 1015,
                                                        userInfo: nil,
                                                        localizedDescription: "A requiered user info dictionary could not be retrieved from a notification")
public let unrecognizableDataError: oklasoftError = oklasoftError(errorCode: 1016,
                                                           userInfo: nil,
                                                           localizedDescription: "Data returned by server was not recognizable for use by the application")
public let invalidURLError: oklasoftError = oklasoftError(errorCode: 1017,
                                                          userInfo: nil,
                                                          localizedDescription: "This is not a valid URL")
