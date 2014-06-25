//
//  otherView.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/16/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class OtherViewDraw{
    var scrollView:UIScrollView! //创建滚动并设置尺寸
    
    init(_controller: OtherController){
        GetUIBaseView(_controller: _controller)
        GetHeadBar(_controller: _controller, _title: "他人资料")
        setScrollView(_controller)
        GetOtherView(_scrollView: scrollView, _uid: _controller.uid)
        GetFriendView(_scrollView: scrollView, _controller: _controller)
    }
    
    func setScrollView(_controller:UIViewController){
        scrollView = UIScrollView(frame:CGRectMake(0, 58, 320, UIScreen.mainScreen().applicationFrame.height-60))
        // 设置可滚动的区域
        //        scrollView.contentSize = CGSizeMake(320, UIScreen.mainScreen().applicationFrame.height)
        _controller.view.addSubview(scrollView)
    }
}

class GetOtherView{
    var topValueBg:UIImageView! // 顶部框体包括背景图
    var userImage:UIImageView! // 顶部用户头像
    var userName:UILabel! // 顶部用户名
    var userSign:UILabel! // 顶部用户签名
    
    var data: NSDictionary!
    var Uid = 0
    
    init(_scrollView: UIScrollView, _uid: Int){
        Uid = _uid
        loadUserData(_scrollView,uid: Uid)
    }
    
    func loadUserData(scrollView: UIScrollView, uid:Int){
        var url = "http://mm.nextsystem.pw/users-get?id=" + String(uid)
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            if data as NSObject == NSNull(){
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            
            self.data = data["data"] as NSDictionary
            self.setView(scrollView)
            var viewMiddle = GetMyDataMiddle(_scrollView: scrollView)
            viewMiddle.middleValueBg.frame = CGRectMake(10, 120, 300, 64)
            })
    }
    
    func setView(scrollView: UIScrollView){
        setTopValueBg(scrollView)
        setUserImage()
        setUserName()
        setUserSign()
    }
    
    func setTopValueBg(uiView:UIView){
        // 创建框体并设置尺寸
        topValueBg = UIImageView(frame:CGRectMake(0,0,320,108))
        //根据图片名，确定图片引用
        topValueBg.image = UIImage(named:"topBgImg.jpg")
        // 将圆图添加到UIView上
        uiView.addSubview(topValueBg)
    }
    
    func setUserImage(){
        var URL = data.objectForKey("avatar") as String
        // 添加圆形头像
        creatRoundImage(topValueBg,CGRectMake(20,15,78,78),UIImage(),3.0).setImage(URL,placeHolder: UIImage(named: "userHead.jpg"));
    }
    
    func setUserName(){
        userName = UILabel(frame:CGRectMake(110, 30, 200, 20))
        userName.text = data.objectForKey("uname") as String
        userName.font = UIFont(name:"Arial",size:20)
        userName.textColor = UIColor.whiteColor()
        userName.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        userName.shadowOffset = CGSizeMake(0, 0.5)
        topValueBg.addSubview(userName)
    }
    
    func setUserSign(){
        userSign = UILabel(frame:CGRectMake(110, 55, 200, 20))
        userSign.text = data.objectForKey("status") as String
        userSign.font = UIFont(name:"Arial",size:14)
        userSign.textColor = UIColor.whiteColor()
        userSign.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        userSign.shadowOffset = CGSizeMake(0, 0.5)
        topValueBg.addSubview(userSign)
    }
}

class GetFriendView{
    var middleListBg:UIView!  //创建框体并设置尺寸
    var topValueBg:UIView! //创建图片并设置尺寸
    var topLabelTitle:UILabel! //创建顶部title
    var bottomBg:UIView!
    var friendImageArray:UIView[] = []
    var friendBtnArray:UIButton[] = []
    
    var dataArray = NSMutableArray()
    var Uid = 0
    var getController:OtherController!
    
    init(_scrollView: UIScrollView, _controller: OtherController){
        getController = _controller
        Uid = _controller.uid
        dataArray = _controller.dataArray
        self.setView(_scrollView)
    }
    
//    func loadFriendData(scrollView: UIScrollView, uid:Int){
//        var url = "http://mm.nextsystem.pw/users-friend?uid=" + String(uid)
    //        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
//    if data as NSObject == NSNull(){
//    UIView.showAlertView("提示",message:"加载失败")
//    return
//    }
//    
//            println(data)
//            var arr = data["data"] as NSArray
//            for data : AnyObject  in arr{
//                self.dataArray.addObject(data)
//            }
//            self.setView(scrollView)
//        })
//    }
    
    func setView(scrollView: UIScrollView){
        getMiddleListBg(scrollView)
        getTopValueBg()
        getTopLabelTitle()
        getBottomBg()
        getFriends()
    }
    
    //创建框体并设置尺寸
    func getMiddleListBg(scrollView: UIScrollView){
        middleListBg = UIView(frame: CGRectMake(10, 196, 300, 85))
        var layer = middleListBg.layer
        layer.backgroundColor = UIColor.clearColor().CGColor
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
        topLabelTitle.text = "共同好友:(\(dataArray.count))"
        topLabelTitle.font = UIFont(name:"Arial",size:12)
        topLabelTitle.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        topLabelTitle.shadowOffset = CGSizeMake(0, 0.5)
        topLabelTitle.textColor = UIColor.whiteColor()
        topValueBg.addSubview(topLabelTitle)
    }
    
    func getBottomBg(){
        bottomBg = UIView(frame:CGRectMake(0, 28, 300, 57))
        var topLayer = bottomBg.layer
        topLayer.backgroundColor = getColorFromDictionary("greyf3").CGColor
        //设置只有右边的两个圆角
        var topMaskPath = UIBezierPath(roundedRect:bottomBg.bounds, byRoundingCorners: UIRectCorner.BottomRight|UIRectCorner.BottomLeft, cornerRadii:CGSizeMake(5, 5))
        var topMaskLayer = CAShapeLayer()
        topMaskLayer.frame = topLayer.bounds
        topMaskLayer.path = topMaskPath.CGPath
        bottomBg.layer.mask = topMaskLayer
        middleListBg.addSubview(bottomBg)
    }
    
    func getFriends(){
        for i in 0..dataArray.count{
            var URL = dataArray[i].objectForKey("avatar") as String
            var imageButton = UIButton(frame:CGRectMake(CGFloat(10+41*i), 10, 36, 36))
            var friend = UIImageView(frame:CGRectMake(0, 0, 36, 36))
            imageButton.backgroundColor = UIColor.clearColor()
            friend.setImage(URL,placeHolder: UIImage(named: "userList01.jpg"));
            friend.layer.cornerRadius = 3
            friend.contentScaleFactor = UIScreen.mainScreen().scale
            friend.contentMode = .ScaleAspectFill
            //    imageView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            friend.clipsToBounds = true
//            self.getController.index = i
            imageButton.addTarget(self.getController,action:"otherImage:",forControlEvents:.TouchUpInside)
            imageButton.tag = i
            friendImageArray.insert(friend, atIndex: i)
            friendBtnArray.insert(imageButton, atIndex: i)
            imageButton.addSubview(friend)
            bottomBg.addSubview(imageButton)
            bottomBg.userInteractionEnabled = true
        }
    }
}


