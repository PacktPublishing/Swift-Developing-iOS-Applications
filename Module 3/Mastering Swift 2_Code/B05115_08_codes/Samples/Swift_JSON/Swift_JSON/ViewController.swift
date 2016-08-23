//
//  ViewController.swift
//  Swift_JSON
//
//  Created by Jon Hoffman on 12/26/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var jsonString = "{\"books\": [{\"name\": \"iOS and OS X Network Development Cookbook\",\"publisher\": \"PacktPub\",\"category\": \"Programming\",\"description\": \"Network development for iOS and OS X\"},{\"name\": \"Mastering Swift\",\"author\": \"Jon Hoffman\",\"publisher\": \"PacktPub\",\"category\": \"Programming\",\"description\": \"Learning Swift\"}]}"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            try parseJson()
        } catch _ {}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func parseJson() throws {
        var myBooks: [Book] = []
        let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        if let data = jsonData {
            
            let jsonDoc : AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            
            if let books = jsonDoc.objectForKey(DocTags.BOOKS_TAG) as? NSArray {
                
                for var i=0; i < books.count; i++ {
                    if let dict = books[i] as? NSDictionary {
                        let book = Book()
                        addValueToBook(book, elementName: DocTags.AUTHOR_TAG, elementValue: (dict.objectForKey(DocTags.AUTHOR_TAG) as? String))
                        addValueToBook(book, elementName: DocTags.CATEGORY_TAG, elementValue: (dict.objectForKey(DocTags.CATEGORY_TAG) as? String))
                        addValueToBook(book, elementName: DocTags.DESCRIPTION_TAG, elementValue: (dict.objectForKey(DocTags.DESCRIPTION_TAG) as? String))
                        addValueToBook(book, elementName: DocTags.NAME_TAG, elementValue: (dict.objectForKey(DocTags.NAME_TAG) as? String))
                        addValueToBook(book, elementName: DocTags.PUBLISHER_TAG, elementValue: (dict.objectForKey(DocTags.PUBLISHER_TAG) as? String))
                        myBooks.append(book)
                    }
                }
                
                for book in myBooks {
                    print("Found - \(book.name) \(book.author)")
                }
                
                
                let myDict = [DocTags.BOOKS_TAG:books]
                do {
                    print("Str:  \(try buildJSON(myDict))")
                } catch {}
            }
        }
    }
    
    func addValueToBook(book: Book, elementName: String, elementValue: String?) {
        if let value = elementValue {
            book.addValue(elementName, withValue: value)
        }
    }
    
    
    func buildJSON(value: AnyObject) throws -> String {
        if NSJSONSerialization.isValidJSONObject(value) {
            let data = try NSJSONSerialization.dataWithJSONObject(value, options: [])
            if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                return string as String
            }
        }
        return ""
    }
    
    
}

