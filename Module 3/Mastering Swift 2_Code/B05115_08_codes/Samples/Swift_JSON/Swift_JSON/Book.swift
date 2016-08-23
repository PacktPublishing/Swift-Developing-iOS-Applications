//
//  Book.swift
//  Swift_XML
//
//  Created by Jon Hoffman on 12/24/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit

class Book {
    var name = ""
    var author = ""
    var publisher = ""
    var category = ""
    var description = ""
    
    func addValue(tagName: String,withValue value: String) {
        switch tagName {
        case DocTags.NAME_TAG:
            self.name = value
        case DocTags.AUTHOR_TAG:
            self.author = value
        case DocTags.PUBLISHER_TAG:
            self.publisher = value
        case DocTags.CATEGORY_TAG:
            self.category = value
        case DocTags.DESCRIPTION_TAG:
            self.description = value
        default:
            print("Unknown element \(tagName)")
        }
    }
}
