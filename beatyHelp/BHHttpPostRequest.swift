//
//  BHHttpPostRequest.swift
//  beatyHelp
//
//  Created by apple  on 14-6-17.
//  Copyright (c) 2014年 XIAOPIU. All rights reserved.
//

import UIKit
import Foundation

class PostRequest:NSMutableURLRequest{
    var mainController:UIViewController!
    init(_controller:UIViewController,_url:String,_postStr:NSString){
        mainController=_controller
        var totalData=NSMutableData()
        var url=NSURL.URLWithString(_url)
        super.init(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 0)
        sendRequest(_postStr);
    }
    
    func sendRequest(_postStr:NSString!){
        var data=_postStr.dataUsingEncoding(NSUTF8StringEncoding)
        self.HTTPMethod="POST"
        self.HTTPBody=data
        
        var conn=PostConnection(request:self,_controller:mainController)
        if(conn==nil){
            return
        }
    }
}

class PostConnection:NSURLConnection,NSURLConnectionDelegate,NSURLConnectionDataDelegate{
    var jsonData:NSDictionary!
    var mainController:UIViewController!
    init(request:NSMutableURLRequest,_controller:UIViewController){
        super.init(request:request, delegate: self)
        mainController=_controller
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
    }
}