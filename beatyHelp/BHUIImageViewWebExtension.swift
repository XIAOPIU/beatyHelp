//
//  BHUIImageViewWebExtension.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/16/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//


import UIKit
import Foundation

extension UIImageView{
    func setImage(urlString:String,placeHolder:UIImage!){
        
        var url = NSURL.URLWithString(urlString)
        var cacheFilename = url.lastPathComponent
        var cachePath = FileUtility.cachePath(cacheFilename)
        var image : AnyObject = FileUtility.imageDataFromPath(cachePath)
        if image as NSObject != NSNull()
        {
            self.image = image as UIImage
        }
        else
        {
            var req = NSURLRequest(URL: url)
            var queue = NSOperationQueue();
            NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
                if error
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            self.image = placeHolder
                        })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            
                            var image = UIImage(data: data)
                            if image == nil
                            {
                                self.image = placeHolder
                            }
                            else
                            {
                                self.image = image
                                FileUtility.imageCacheToPath(cachePath,image:data)
                            }
                        })
                }
            })
        }
    }
}
