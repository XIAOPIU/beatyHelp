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
    var type:String!
    init(_controller:UIViewController,_url:String,_postStr:NSString,_type:String){
        mainController=_controller
        var totalData=NSMutableData()
        var url=NSURL.URLWithString(_url)
        super.init(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 0)
        type=_type
        sendRequest(_postStr);
    }
    
    func sendRequest(_postStr:NSString!){
        var data=_postStr.dataUsingEncoding(NSUTF8StringEncoding)
        self.HTTPMethod="POST"
        self.HTTPBody=data
        
        var conn=PostConnection(request:self,_controller:mainController,_type:type)
        if(conn==nil){
            return
        }
    }
}

class PostConnection:NSURLConnection,NSURLConnectionDelegate,NSURLConnectionDataDelegate{
    var jsonData:NSDictionary!
    var type = ""
    var mainController:UIViewController!
    init(request:NSMutableURLRequest,_controller:UIViewController,_type:String){
        super.init(request:request, delegate: self)
        mainController=_controller
        type=_type
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        if type=="pub"{
            println(self.jsonData)
//            if self.jsonData["code"] as NSObject == 0 {
                BHAlertView().showSuccess(mainController, title: "发布成功", subTitle: "您已成功发布任务，快去任务广场看看吧",alertType:"pubSuccess")
//            }
//            else{
//                BHAlertView().showWarning(mainController, title: "发布失败", subTitle: "看看是不是有内容没有填哟")
//            }
        }
    }
}