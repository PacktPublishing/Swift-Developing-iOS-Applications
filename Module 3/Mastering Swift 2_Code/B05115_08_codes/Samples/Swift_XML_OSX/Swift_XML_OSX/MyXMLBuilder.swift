//
//  MyXMLBuilder.swift
//  Swift_XML
//
//  Created by Jon Hoffman on 12/27/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import Cocoa
import Foundation

class MyXMLBuilder: NSObject {
    
    func buildXMLString(books: [Book]?) -> String {
        if let myBooks = books {
            let xmlRoot = NSXMLElement(name: DocTags.BOOKS_TAG)
            let xmlData = NSXMLDocument(rootElement: xmlRoot)
            for book in myBooks {
                let bookElement = NSXMLElement(name: DocTags.BOOK_TAG)
                xmlRoot.addChild(bookElement)
                let nameAttribute = NSXMLNode.attributeWithName(DocTags.NAME_TAG, stringValue:book.name) as! NSXMLNode
                bookElement.addAttribute(nameAttribute)
                bookElement.addChild(NSXMLElement(name: DocTags.AUTHOR_TAG, stringValue: book.author))
                bookElement.addChild(NSXMLElement(name: DocTags.CATEGORY_TAG, stringValue: book.category))
                bookElement.addChild(NSXMLElement(name: DocTags.DESCRIPTION_TAG, stringValue: book.description))
                bookElement.addChild(NSXMLElement(name: DocTags.PUBLISHER_TAG, stringValue: book.publisher))
                
            }
            return xmlData.XMLString
        } else {
            return ""
        }
    }
}
