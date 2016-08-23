//
//  MyXMLParser.swift
//  Swift_XML
//
//  Created by Jon Hoffman on 12/26/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit

class MyXMLParser: NSObject, NSXMLParserDelegate {
    
    var books: [Book]?
    var book: Book?
    var elementData = ""
    
    func parseXmlString(xmlString: String) {
        let xmlData = xmlString.dataUsingEncoding(NSUTF8StringEncoding)
        let parser = NSXMLParser(data: xmlData!)
        parser.delegate = self
        parser.parse()
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("Started XML parser")
    }
    
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == DocTags.BOOKS_TAG {
            books = []
        } else if elementName == DocTags.BOOK_TAG {
            book = Book()
            if let name = attributeDict[DocTags.NAME_TAG] {
                book!.addValue(DocTags.NAME_TAG, withValue: name )
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == DocTags.BOOK_TAG {
            if let myBook = book {
                if var _ = books {
                    books!.append(myBook)
                }
            }
            book = Book()
        } else if let myBook = book {
            myBook.addValue(elementName, withValue: elementData)
        }
        elementData = ""
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        elementData += string
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("Parse Error occured \(parseError)")
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        if let myBooks = books {
            for myBook in myBooks {
                print("Found - \(myBook.name) \(myBook.author)")
            }
        }
        
        let builder = MyXMLBuilder()
        print(builder.buildXMLString(books))
    }
}
