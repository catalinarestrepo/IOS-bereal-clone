//
//  Users.swift
//  Bereal-clone
//
//  Created by Khiem Tran Le on 3/26/23.
//

import Foundation
import ParseSwift


struct Users: ParseUser {
    // These are required by `ParseObject`.
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // These are required by `ParseUser`.
    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String: [String: String]?]?

    // Your custom properties.
    var lastPostedDate: Date?
    // var customKey: String?
}
