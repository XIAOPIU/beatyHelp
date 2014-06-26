//
//  BHHttpManager.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/17/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

//import Foundation
//import UIkit
//let BOUNDARY = "----------V2ymHFg03ehbqgZCaKO6jy" //标识符
//
//var downloadList:NSMutableArray! = NSMutableArray()
//var uploadList:NSMutableArray! = NSMutableArray()
//
//class Download{
//    var downSession:NSURLSession!
//    var downRequest:NSURLRequest!
//    var downTask:NSURLSessionDownloadTask!
//    var saveName:String!
//    var isDowning:Bool!
//    var callBack: ((NSURL!, NSURLResponse!, NSError!) -> Void)!
//    var progressFunc:((Float!)->Void)!
//    
//}
//
//class Upload{
//    var upSession:NSURLSession!
//    var upRequest:NSMutableURLRequest!
//    var upTask:NSURLSessionUploadTask!
//    var callBack:((NSData!, NSURLResponse!, NSError!) -> Void)!
//    var progressFunc:((Float!)->Void)!
//}
//
//class HttpData{
//    var httpDataSession:NSURLSession!
//    var httpDataRequest:NSMutableURLRequest!
//    var httpDataTask:NSURLSessionDataTask!
//    var callBack:((NSData!, NSURLResponse!, NSError!) -> Void)!
//}
//
//class VKHttpManager:NSObject,NSURLSessionDelegate{
//    
//    class var manager:VKHttpManager{
//    return VKHttpManager()
//    }
//    
//    class func initDown(URL downUrl:String!,saveName:String!,progressFunc:((Float!)->Void)!,backFunc: ((NSURL!, NSURLResponse!, NSError!) -> Void)!)->Download{
//        var down:Download = Download()
//        down.downSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),delegate:manager,delegateQueue:nil)
//        down.downRequest = NSURLRequest(URL: NSURL(string:downUrl))
//        downloadList.addObject(down)
//        down.downTask = down.downSession.downloadTaskWithRequest(down.downRequest,completionHandler:backFunc)
//        down.callBack = backFunc
//        down.saveName = saveName
//        down.progressFunc = progressFunc
//        return down
//    }
//    
//    class func startDownload(down:Download!){
//        down.isDowning = true
//        down.downTask.resume()
//    }
//    
//    class func cancleDownload(down:Download!){
//        down.isDowning = false
//        down.downTask.cancel()
//    }
//    
//    class func initUp(upUrl:String!,fileParam:String!,filePath:String!,keyArry:NSArray!,valueArry:NSArray!,progressFunc:((Float!)->Void)!,backFuc:((NSData!, NSURLResponse!, NSError!) -> Void)!)->Upload{
//        var up = Upload()
//        up.upSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),delegate:manager,delegateQueue:NSOperationQueue.mainQueue())
//        up.upRequest = NSMutableURLRequest(URL: NSURL(string:upUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)))
//        up.upRequest.HTTPMethod = "POST"
//        
//        var contentType = "multipart/form-data; boundary="+BOUNDARY
//        up.upRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
//        
//        var body = NSMutableData.data()
//        var fileData = NSData(contentsOfFile:filePath)
//        
//        if keyArry != nil && valueArry != nil && valueArry.count > 0 && keyArry.count > 0{
//            for var i=0; i < keyArry.count; ++i{
//                body.appendData(String("--"+BOUNDARY+"\r\n").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true))
//                body.appendData(String("Content-Disposition: form-data; name=\""+String(keyArry.objectAtIndex(i) as String)+"\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true))
//                body.appendData((String(valueArry.objectAtIndex(i) as String)+"\r\n").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true))
//            }
//        }
//        
//        if fileData != nil {
//            body.appendData(String("--"+BOUNDARY+"\r\n").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true))
//            body.appendData(String("Content-Disposition: form-data; name=\""+fileParam+"\"; filename=\""+filePath.lastPathComponent+"\"\r\n").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true))
//            body.appendData(String("Content-Type: application/zip\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true))
//            body.appendData(fileData)
//            body.appendData(String("\r\n").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true))
//        }
//        body.appendData(String("--"+BOUNDARY+"--\r\n").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true));
//        
//        up.upTask = up.upSession.uploadTaskWithRequest(up.upRequest, fromData:body,completionHandler:backFuc)
//        up.progressFunc = progressFunc
//        up.callBack = backFuc
//        uploadList.addObject(up)
//        return up
//    }
//    
//    class func startUpload(var up:Upload!){
//        up.upTask.resume()
//    }
//    
//    class func cancleUpload(var up:Upload!){
//        up.upTask.cancel()
//    }
//    
//    class func initHttpData(httpDataUrl:String!,keyArry:NSArray!,valueArry:NSArray!,backFuc:((NSData!, NSURLResponse!, NSError!) -> Void)!)->HttpData{
//        var httpData = HttpData()
//        httpData.httpDataSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),delegate:manager,delegateQueue:nil)
//        httpData.httpDataRequest = NSMutableURLRequest(URL: NSURL(string:httpDataUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)))
//        httpData.httpDataRequest.HTTPMethod = "POST"
//        var params:String=""
//        if keyArry != nil && valueArry != nil && valueArry.count > 0 && keyArry.count > 0{
//            for var i=0; i < keyArry.count; ++i{
//                if i == 0 {
//                    params = String(keyArry.objectAtIndex(i) as String)+"="+String(valueArry.objectAtIndex(i) as String)
//                }else {
//                    params = params+"&"+String(keyArry.objectAtIndex(i) as String)+"="+String(valueArry.objectAtIndex(i) as String)
//                }
//            }
//        }
//        httpData.httpDataRequest.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
//        httpData.httpDataTask = httpData.httpDataSession.dataTaskWithRequest(httpData.httpDataRequest,completionHandler:backFuc)
//        httpData.callBack = backFuc
//        return httpData
//    }
//    
//    class func startHttpData(var httpData:HttpData){
//        httpData.httpDataTask.resume()
//    }
//    
//    class func cancleHttpData(var httpData:HttpData){
//        httpData.httpDataTask.cancel()
//    }
//    
//    
//    
//    //    回调 反馈
//    func URLSession(session: NSURLSession!, downloadTask: NSURLSessionDownloadTask!, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
//        var progress = Float(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite));
//        for var i=0; i<downloadList.count; ++i{
//            var d =  downloadList[i] as Download
//            d.progressFunc(progress)
//        }
//    }
//    
//    func URLSession(session: NSURLSession!, downloadTask: NSURLSessionDownloadTask!, didFinishDownloadingToURL location: NSURL!){
//        var defaultFileMag:NSFileManager! = NSFileManager.defaultManager()
//        for var i = 0 ; i<downloadList.count; ++i{
//            var d =  downloadList[i] as Download
//            if d.downSession == session {
//                var destinationPath = NSURL(fileURLWithPath:String(FileOp.getDocumentPath()+"/"+d.saveName))
//                defaultFileMag.removeItemAtURL(destinationPath,error:nil);
//                var copyFile:Bool = defaultFileMag.copyItemAtURL(location,toURL:destinationPath,error:nil)
//                if copyFile == false {
//                    return
//                }
//                downloadList.removeObjectAtIndex(i)
//            }
//        }
//    }
//    
//    func URLSession(session: NSURLSession!, task: NSURLSessionTask!, didCompleteWithError error: NSError!){
//        for var i = 0 ; i<downloadList.count; ++i{
//            var d =  downloadList[i] as Download
//            if d.downSession == session {
//                downloadList.removeObjectAtIndex(i)
//            }
//        }
//        
//        for var i = 0 ; i<uploadList.count; ++i{
//            var d =  uploadList[i] as Upload
//            if d.upSession == session {
//                uploadList.removeObjectAtIndex(i)
//            }
//        }
//    }
//    
//    func URLSession(session: NSURLSession!, task: NSURLSessionTask!, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64){
//        var progress = Float(Float(totalBytesSent)/Float(totalBytesExpectedToSend));
//        for var i=0; i<uploadList.count; ++i{
//            var u =  uploadList[i] as Upload
//            u.progressFunc(progress)
//        }
//    }
//    
//    
//}