//
//  BHHttpRequest.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/12/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import UIKit
import Foundation

class BHHttpRequest: NSObject {
    init(){super.init()}
    
    class func requestWithURL(urlString:String,completionHandler:(data:AnyObject)->Void)
    {
        var URL = NSURL.URLWithString(urlString)
        var req = NSURLRequest(URL: URL)
        var queue = NSOperationQueue();
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
            if error {
                dispatch_async(dispatch_get_main_queue(),{
                    completionHandler(data:NSNull())
                })
            }else{
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                dispatch_async(dispatch_get_main_queue(),{completionHandler(data:jsonData)})
            }
        })
    }
}