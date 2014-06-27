//
//  BHFileOp.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/27/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import UIkit
import Foundation

class BHFileOp{
    class func  getDocumentPath()->String{
        var path:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask,true)
        return path[0] as String
    }
    
    class func  getCachesPath()->String{
        var path:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory,NSSearchPathDomainMask.UserDomainMask,true)
        return path[0] as String
    }
    
    class func getImageForBundle(fileName: String!)->UIImage{
        return UIImage(named:fileName)
    }
    
    class func getImageFormDecoument(fileName: String!)->UIImage{
        return UIImage(contentsOfFile: getDocumentPath()+"/"+fileName)
    }
    
    class func saveBundleImageToDoc(imageName: String!,saveImageName: String!)->Bool{
        var uniquePath:String = getDocumentPath()+"/"+saveImageName
        
        var blHave:Bool = NSFileManager.defaultManager().fileExistsAtPath(uniquePath)
        if blHave {
            var blDele:Bool = NSFileManager.defaultManager().removeItemAtPath(uniquePath, error: nil)
            if blDele {
                println("delet success")
            }else{
                println("delet erro")
                return false
            }
        }
        var arry =  imageName.componentsSeparatedByString(".")
        var path:String =  NSBundle.mainBundle().pathForResource(arry[0] as String, ofType: arry[1] as String)
        var data:NSData = NSData.dataWithContentsOfFile(path,options: NSDataReadingOptions.DataReadingMapped,error:nil )
        var result:Bool = data.writeToFile(uniquePath, atomically: true)
        return result
    }
    
    class func deletFileFromDoc(fileName: String!)->Bool{
        var blHave:Bool = NSFileManager.defaultManager().fileExistsAtPath(getDocumentPath()+"/"+fileName)
        if blHave {
            return NSFileManager.defaultManager().removeItemAtPath(getDocumentPath()+"/"+fileName, error: nil)
        }else{
            return false
        }
    }
    
    class func saveDataPlistToDoc(plistName:String!,listData:NSMutableDictionary!)->Bool{
        var result:Bool =  listData.writeToFile(getDocumentPath()+"/"+plistName, atomically: true)
        return result;
    }
    
}



func createDictionaly() {
    
    // specify the path of our plist file in OS
    var sysDocPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
    var path = sysDocPaths.objectAtIndex(0) as String
    var filePath = path.stringByAppendingPathComponent("allCities.plist")
    
    // create the dictionary with file
    var cityDictionary = NSMutableDictionary.dictionaryWithContentsOfFile(filePath)
    
    if cityDictionary {
        println("the existing dictionary is \(cityDictionary) and path is \(filePath)")
    }else{
        cityDictionary = NSMutableDictionary(object: "1", forKey: "key")
        cityDictionary!.writeToFile(filePath, atomically: true)
        println("file created")
    }
}