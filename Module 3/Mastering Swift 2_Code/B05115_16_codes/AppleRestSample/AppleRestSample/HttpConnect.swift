//
//  AppleConnect.swift
//  AppleRestSample
//
//  Created by Jon Hoffman on 3/10/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit
import SystemConfiguration

public class HttpConnect: NSObject {
    
    public enum ConnectionType {
        case NONETWORK
        case MOBILE3GNETWORK
        case WIFINETWORK
    }
    
    private func urlEncode(s: String) -> String {
        return CFURLCreateStringByAddingPercentEscapes(nil, s, nil,
            "!*'\"();:@&=+$,/?%#[]", CFStringBuiltInEncodings.UTF8.rawValue) as String
    }

    
    public typealias dataFromURLCompletionClosure = (NSURLResponse!, NSData!) -> Void
    
    public func sendGetRequest (
        handler: dataFromURLCompletionClosure) {
            
        let sessionConfiguration =
            NSURLSessionConfiguration.defaultSessionConfiguration();
        
        let urlString =
            "https://itunes.apple.com/search?term=jimmy+buffett"
        
        if let encodeString =
            urlString.stringByAddingPercentEncodingWithAllowedCharacters(
                NSCharacterSet.URLQueryAllowedCharacterSet()),
            url = NSURL(string: encodeString) {
        
            let request = NSMutableURLRequest(URL:url)
            request.HTTPMethod = "GET"
            let urlSession = NSURLSession(
                configuration:sessionConfiguration, delegate: nil, delegateQueue: nil)
            
            let sessionTask = urlSession.dataTaskWithRequest(request) {
                (data, response, error) in
                
                handler(response, data)
            }
            sessionTask.resume()
        }
    }
    
    public func sendPostRequest(handler: dataFromURLCompletionClosure) {
        
        let sessionConfiguration =
        NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let urlString = "http://httpbin.org/post"
        if let encodeString =
            urlString.stringByAddingPercentEncodingWithAllowedCharacters(
                NSCharacterSet.URLQueryAllowedCharacterSet()),
            url = NSURL(string: encodeString) {
            
            let request = NSMutableURLRequest(URL:url)
            request.HTTPMethod = "POST"
            let params = dictionaryToQueryString(["One":"1 and 1", "Two":"2 and 2"])
            request.HTTPBody = params.dataUsingEncoding(
                NSUTF8StringEncoding, allowLossyConversion: true)
                
            let urlSession = NSURLSession(
                configuration:sessionConfiguration, delegate: nil, delegateQueue: nil)
            
            let sessionTask = urlSession.dataTaskWithRequest(request) {
                (data, response, error) in
                
                handler(response, data)
            }
            sessionTask.resume()
        }
    }
    
    private func dictionaryToQueryString(dict: [String : String]) -> String {
        var parts = [String]()
        for (key, value) in dict {
            let part : String = key + "=" + value
            parts.append(part);
        }
        return parts.joinWithSeparator("&")
        
    }
    
    public func networkConnectionType(hostname: NSString) -> ConnectionType {
        
        let reachabilityRef = SCNetworkReachabilityCreateWithName(nil,hostname.UTF8String)
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachabilityRef!, &flags)
        
        let reachable: Bool = (flags.rawValue & SCNetworkReachabilityFlags.Reachable.rawValue) != 0
        let needsConnection: Bool = (flags.rawValue & SCNetworkReachabilityFlags.ConnectionRequired.rawValue) != 0
        if reachable && !needsConnection {
            // determine what type of connection is available
            let isCellularConnection = (flags.rawValue & SCNetworkReachabilityFlags.IsWWAN.rawValue) != 0
            if isCellularConnection {
                return ConnectionType.MOBILE3GNETWORK // cellular connection available
            } else {
                return ConnectionType.WIFINETWORK // wifi connection available
            }
        }
        return ConnectionType.NONETWORK // no connection at all
    }
}
