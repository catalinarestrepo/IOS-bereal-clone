//
//  Post.swift
//  Bereal-clone
//
//  Created by Khiem Tran Le on 3/26/23.
//

import Foundation
import ParseSwift

struct Post: ParseObject {
    // These are required by ParseObject
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // Custom properties.
    var caption: String?
    var user: Users?
    var imageFile: ParseFile?
}
