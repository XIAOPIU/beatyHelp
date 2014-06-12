//
//  myDataView.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class MyDataViewDraw{
    var scrollView:UIScrollView! //创建滚动并设置尺寸
    
    init(_controller: UIViewController){
        getScrollView(_controller)
        GetUIBaseView(_controller: _controller)
        GetMainViewTop(_controller: _controller,_pageNum: 2)
        GetMyDataMiddle(_scrollView: scrollView)
        GetMiddleList(_scrollView: scrollView)
        GetMydataBtn(_scrollView: scrollView)
        GetFootBar(_controller: _controller, _index: 3)
    }
    
    func getScrollView(controller: UIViewController){
        scrollView = UIScrollView(frame:CGRectMake(0, 128, 320, 317))
        // 设置可滚动的区域
        scrollView.contentSize = CGSizeMake(320, 335)
        controller.view.addSubview(scrollView)
    }
}

class GetMyDataMiddle{
    var middleValueBg:UIView! // 创建框体并设置尺寸
    var leftValueBg:UIView! // 创建左边背景图片并设置尺寸
    var leftLabelValue:UILabel! // 左边的值
    var leftLabelName:UILabel! // 左边的名称
    var rightValueBg:UIView! // 创建右边背景图片并设置尺寸
    var rightLabelArray:UILabel[] = [] // 右边的值
    let ListNum = 4
    let middleValueValue = getDictionary("myData").objectForKey("middleValue").objectForKey("middleValueValue") as NSArray
    let middleValueName = getDictionary("myData").objectForKey("middleValue").objectForKey("middleValueName") as NSArray
    let rightcolorArray:UIColor[] = [UIColor.whiteColor(), getColorFromDictionary("blue"), getColorFromDictionary("grey9b"), getColorFromDictionary("green"), getColorFromDictionary("red")]
    
    init(_scrollView:UIScrollView){
        getMiddleValueBg(_scrollView)
        getLeftValueBg()
        getLeftLabelValue()
        getLeftLabelName()
        getRightValueBg()
        getRightLabelArray()
    }
    
    func getMiddleValueBg(_scrollView: UIScrollView){
        middleValueBg = UIView(frame:CGRectMake(10, 10, 300, 64))
        var layer = middleValueBg.layer
        layer.shadowOffset = CGSizeMake(0, 1)
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.05
        _scrollView.addSubview(middleValueBg)
    }
    
    func getLeftValueBg(){
        //创建图片并设置尺寸
        leftValueBg = UIView(frame:CGRectMake(0, 0, 64, 64))
        //读取实例的layer属性
        var leftlayer = leftValueBg.layer
        //设置红色为控件背景
        leftlayer.backgroundColor = getColorFromDictionary("red").CGColor
        //设置只有左边的两个圆角
        var leftMaskPath = UIBezierPath(roundedRect:leftValueBg.bounds, byRoundingCorners: UIRectCorner.TopLeft|UIRectCorner.BottomLeft, cornerRadii:CGSizeMake(5, 5))
        var leftMaskLayer = CAShapeLayer()
        leftMaskLayer.frame = leftlayer.bounds
        leftMaskLayer.path = leftMaskPath.CGPath
        leftValueBg.layer.mask = leftMaskLayer
        middleValueBg.addSubview(leftValueBg)
    }
    
    func getLeftLabelValue(){
        leftLabelValue = UILabel(frame:CGRectMake(0, 12, 64, 24))
        leftLabelValue.text = toString(middleValueValue[0])
        leftLabelValue.font = UIFont(name:"Arial",size:25)
        leftLabelValue.shadowOffset = CGSizeMake(0, 1)
        leftLabelValue.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        leftLabelValue.textColor = rightcolorArray[0]
        leftLabelValue.textAlignment = NSTextAlignment.Center
        leftValueBg.addSubview(leftLabelValue)
    }
    
    func getLeftLabelName(){
        leftLabelName = UILabel(frame:CGRectMake(0, 37, 64, 24))
        leftLabelName.text = toString(middleValueName[0])
        leftLabelName.font = UIFont(name:"Arial",size:12)
        leftLabelName.shadowOffset = CGSizeMake(0, 0.5)
        leftLabelName.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
        leftLabelName.textColor = rightcolorArray[0]
        leftLabelName.textAlignment = NSTextAlignment.Center
        leftValueBg.addSubview(leftLabelName)
    }
    
    func getRightValueBg(){
        //创建图片并设置尺寸
        rightValueBg = UIView(frame:CGRectMake(64, 0, 236, 64))
        //读取实例的layer属性
        var rightlayer = rightValueBg.layer
        //设置白色为控件背景
        rightlayer.backgroundColor = getColorFromDictionary("greyf3").CGColor
        //设置只有右边的两个圆角
        var rightMaskPath = UIBezierPath(roundedRect:rightValueBg.bounds, byRoundingCorners: UIRectCorner.TopRight|UIRectCorner.BottomRight, cornerRadii:CGSizeMake(5, 5))
        var rightMaskLayer = CAShapeLayer()
        rightMaskLayer.frame = rightlayer.bounds
        rightMaskLayer.path = rightMaskPath.CGPath
        rightValueBg.layer.mask = rightMaskLayer
        middleValueBg.addSubview(rightValueBg)
    }
    
    func getRightLabelArray(){
        for i in 0..ListNum{
            var rightLabelValue = UILabel(frame:CGRectMake(CGFloat(i*59), 12, 59, 24))
            rightLabelValue.text = toString(middleValueValue[i+1])
            rightLabelValue.font = UIFont(name:"Arial",size:25)
            rightLabelValue.textColor = rightcolorArray[i+1]
            rightLabelValue.textAlignment = NSTextAlignment.Center
            rightValueBg.addSubview(rightLabelValue)
            rightLabelArray.insert(rightLabelValue, atIndex: i)
            
            var rightLabelName = UILabel(frame:CGRectMake(CGFloat(i*59), 37, 59, 24))
            rightLabelName.text = toString(middleValueName[i+1])
            rightLabelName.font = UIFont(name:"Arial",size:12)
            rightLabelName.textColor = getColorFromDictionary("grey33")
            rightLabelName.textAlignment = NSTextAlignment.Center
            rightValueBg.addSubview(rightLabelName)
            
            if i != ListNum-1{
                var rightLine = UIImageView(image: UIImage(named:"rightValueLine"))
                rightLine.frame = CGRectMake(CGFloat(58+i*59), 7, 0.5, 52)
                rightValueBg.addSubview(rightLine)
            }
        }
    }
}

class GetMiddleList{
    var middleListBg:UIView!  //创建框体并设置尺寸
    var topValueBg:UIView! //创建图片并设置尺寸
    var topLabelTitle:UILabel! //创建顶部title
    var topLabelMore:UILabel! //创建顶部more
    var middleValueBgArray:UIView[] = []
    let ListNum = 4
    
    init(_scrollView: UIScrollView){
        getMiddleListBg(_scrollView)
        getTopValueBg()
        getTopLabelTitle()
        getTopLabelMore()
        getMiddleValueBgArray()
    }
    
    //创建框体并设置尺寸
    func getMiddleListBg(scrollView: UIScrollView){
        middleListBg = UIView(frame: CGRectMake(10, 86, 300, CGFloat(28*ListNum)))
        var layer = middleListBg.layer
        layer.shadowOffset = CGSizeMake(0, 1)
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.05
        scrollView.addSubview(middleListBg)
    }
    
    func getTopValueBg(){
        topValueBg = UIView(frame:CGRectMake(0, 0, 300, 28))
        var topLayer = topValueBg.layer
        topLayer.backgroundColor = getColorFromDictionary("red").CGColor
        //设置只有右边的两个圆角
        var topMaskPath = UIBezierPath(roundedRect:topValueBg.bounds, byRoundingCorners: UIRectCorner.TopRight|UIRectCorner.TopLeft, cornerRadii:CGSizeMake(5, 5))
        var topMaskLayer = CAShapeLayer()
        topMaskLayer.frame = topLayer.bounds
        topMaskLayer.path = topMaskPath.CGPath
        topValueBg.layer.mask = topMaskLayer
        middleListBg.addSubview(topValueBg)
    }
    
    func getTopLabelTitle(){
        topLabelTitle = UILabel(frame: CGRectMake(120, 8, 80, 12))
        topLabelTitle.text = "好人点:(452)"
        topLabelTitle.font = UIFont(name:"Arial",size:12)
        topLabelTitle.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        topLabelTitle.shadowOffset = CGSizeMake(0, 0.5)
        topLabelTitle.textColor = UIColor.whiteColor()
        topValueBg.addSubview(topLabelTitle)
    }
    
    func getTopLabelMore(){
        topLabelMore = UILabel(frame: CGRectMake(260, 8, 30, 12))
        var content = NSMutableAttributedString(string: String("更多"))
        var contentRange = NSRange(location: 0, length: content.length)
        //        var getStyle = NSUnderlineStyle.StyleSingle
        var getValue = NSNumber(integer:2)
        content.addAttribute(NSUnderlineStyleAttributeName, value: getValue, range: contentRange)
        topLabelMore.attributedText = content
        topLabelMore.font = UIFont(name:"Arial",size:12)
        topLabelMore.shadowColor = UIColor(red:0, green:0, blue: 0, alpha:0.45)
        topLabelMore.shadowOffset = CGSizeMake(0, 0.5)
        topLabelMore.textColor = UIColor.whiteColor()
        topValueBg.addSubview(topLabelMore)
    }
    
    func getMiddleValueBgArray(){
        for i in 1..ListNum {
            var middleValueBg = UIView(frame:CGRectMake( 0, CGFloat(28*i), 300, 28))
            var middleLayer = middleValueBg.layer
            if i%2 == 1{
                middleLayer.backgroundColor = getColorFromDictionary("greyf3").CGColor
            }else{
                middleLayer.backgroundColor = getColorFromDictionary("greyd8").CGColor
            }
            if i == ListNum-1 {
                var middleMaskPath = UIBezierPath(roundedRect: middleValueBg.bounds, byRoundingCorners: UIRectCorner.BottomLeft|UIRectCorner.BottomRight, cornerRadii:CGSizeMake(5, 5))
                var middleMaskLayer = CAShapeLayer()
                middleMaskLayer.frame = middleLayer.bounds
                middleMaskLayer.path = middleMaskPath.CGPath
                middleValueBg.layer.mask = middleMaskLayer
            }
            middleValueBgArray.insert(middleValueBg, atIndex: i-1)
            middleListBg.addSubview(middleValueBg)
        }
    }
}

class GetMydataBtn{
    var btnArray: UIButton[] = []
    
    init(_scrollView: UIScrollView){
        var btnNum = 3
        var btnNameArray = ["历史消息","设  置","登  出"]
        for i in 0..btnNum{
            var img = i == btnNum-1 ? UIImage(named: "blackBtn") : UIImage(named: "blueBtn")
            img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
            img.accessibilityFrame = CGRectMake(0, 0, 304, 36)
            var button = GetlargeBtn(_frame : CGRectMake(7, CGFloat(205+40*i), 306, 36), _img : img, _title : btnNameArray[i]).button
            btnArray.insert(button, atIndex: i)
            _scrollView.addSubview(button)
        }
    }
}