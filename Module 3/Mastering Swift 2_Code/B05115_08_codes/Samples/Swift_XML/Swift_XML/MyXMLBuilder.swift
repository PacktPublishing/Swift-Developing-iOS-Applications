//
//  MyXMLBuilder.swift
//  Swift_XML
//
//  Created by Jon Hoffman on 12/27/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit

class MyXMLBuilder: NSObject {
    func buildXMLString(books: [Book]?) -> String {
        var xmlString = ""
        if let myBooks = books {
            xmlString = "<\(DocTags.BOOKS_TAG)>"
            for book in myBooks {
                xmlString += "<\(DocTags.BOOK_TAG) \(DocTags.NAME_TAG)=\"\(book.name)\">"
                xmlString += getElementString(DocTags.AUTHOR_TAG, elementValue: book.author)
                xmlString += getElementString(DocTags.CATEGORY_TAG, elementValue: book.category)
                xmlString += getElementString(DocTags.DESCRIPTION_TAG, elementValue: book.description)
                xmlString += getElementString(DocTags.PUBLISHER_TAG, elementValue: book.publisher)
                xmlString += "<\\\(DocTags.BOOK_TAG)>"
            }
            xmlString += "<\\\(DocTags.BOOKS_TAG)>"
        }
        return xmlString
    }
    
    func getElementString(elementName: String, elementValue: String) ->String {
        return "<\(elementName)>\"\(elementValue)\"<\\\(elementName)>"
    }
}
