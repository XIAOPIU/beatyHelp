//
//  BHTool.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/6/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

/**
*  添加圆形图片，带描边
*
*  @param view 需要添加此圆图的UIView
*  @param frame 需要设置的CGRect尺寸
*  @param name 需要使用的图像名称
*  @param border 描边的大小
*  @return 返回创建的UIimageView
*/
func creatRoundImage(view:UIView,frame:CGRect,img:UIImage,border:Float)->UIImageView{
    //创建图片并设置尺寸
    var imageView = UIImageView(frame:frame)
    //根据图片名，确定图片引用
    imageView.image = img
    //是否设置边框以及是否可见
    imageView.layer.masksToBounds = true
    //设置边框的宽度
    imageView.layer.borderWidth = CGFloat(border)
    //设置边框的颜色
    imageView.layer.borderColor = UIColor(white: 1, alpha: 1).CGColor
    //设置边框圆角的幅度为宽度的一半，由此变成圆形
    //图片截取高度居中显示
    imageView.layer.cornerRadius = imageView.frame.size.width/2
    imageView.contentScaleFactor = UIScreen.mainScreen().scale
    imageView.contentMode = .ScaleAspectFill
//    imageView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
    imageView.clipsToBounds = true
    
    //将圆图添加到UIView上
    view.addSubview(imageView)
    return imageView
}

/**
*  获取statuses.plist文件的数据
*
*  @param string 需要获取的字典目录名
*
*  @return 返回所查找的目录名字典
*/
func getDictionary(string:String)->AnyObject{
    var plistPath = NSBundle.mainBundle().pathForResource("statuses",ofType: "plist")
    var dictionary = NSDictionary(contentsOfFile:plistPath)
    return dictionary.objectForKey(string)
}

/**
*  获取save.plist文件的数据
*
*  @param string 需要获取的字典目录名
*
*  @return 返回所查找的目录名字典
*/
func getSaveDictionary(string:String)->AnyObject{
    var plistPath = NSBundle.mainBundle().pathForResource("save",ofType: "plist")
    var dictionary = NSDictionary(contentsOfFile:plistPath)
    return dictionary.objectForKey(string)
}

/**
*  通过字典查出相应颜色
*
*  @param dictionaryName 需要获取的颜色name
*
*  @return 返回相应的UIColor对象
*/
func getColorFromDictionary(dictionaryName:String) -> UIColor{
    var colorList : AnyObject = getDictionary("colorList")
    var colorArray = NSMutableArray()
    colorArray = colorList.objectForKey(dictionaryName) as NSMutableArray
    return UIColor(red: CGFloat(colorArray[0] as NSNumber)/255, green: CGFloat(colorArray[1] as NSNumber)/255, blue: CGFloat(colorArray[2] as NSNumber)/255, alpha: CGFloat(colorArray[3] as NSNumber))
}



/**
*  通过16进制RGB来返回UIColor
*
*  @param rgbValue 16进制RGB值 例如：0x333333
*
*  @return 返回相应的UIColor对象
*/
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}



extension NSDictionary {
    func stringAttributeForKey(key:String)->String
    {
        var obj : AnyObject! = self[key]
        if obj as NSObject == NSNull()
        {
            return ""
        }
        if obj.isKindOfClass(NSNumber)
        {
            var num = obj as NSNumber
            return num.stringValue
        }
        return obj as String
    }
}