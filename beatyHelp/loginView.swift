//
//  myDataView.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class LoginViewDraw{
    var scrollView:UIScrollView! //创建滚动并设置尺寸
    var dataArray = NSMutableArray() //用户数据
    
    init(_controller: LoginController){
        GetUIBaseView(_controller: _controller)
        getScrollView(_controller)
        setBg(_controller)
        setTop(_controller)
//        GetMainViewTop(_controller: _controller,_pageNum: 2)
//        GetMyDataMiddle(_scrollView: scrollView)
//        GetMiddleList(_scrollView: scrollView)
        loadData(_controller)
       
    }
    
    func getScrollView(controller: LoginController){
        scrollView = UIScrollView(frame:CGRectMake(0, 70, 320, UIScreen.mainScreen().applicationFrame.height-70))
        // 设置可滚动的区域
        
        if  UIScreen.mainScreen().applicationFrame.height == 460 {
            scrollView.contentSize = CGSizeMake(320, 1000)
        }
        controller.view.addSubview(scrollView)
    }
    
    func setBg(controller: LoginController){
        controller.view.backgroundColor = UIColor(patternImage: UIImage(named:"loginBg.jpg"))
    }
    
    
    func setTop(controller: LoginController){
        //设置顶部背景
        var topBg = UIView(frame:CGRectMake(0, 20, 320, 50))
        topBg.backgroundColor=UIColor.blackColor()
        topBg.alpha=0.5
        controller.view.addSubview(topBg)
        
        //设置顶部文案
        var topLabel=UILabel(frame:CGRectMake(28, 35, 300, 20))
        topLabel.text="请从以下虚拟账户中选择一个身份登录"
        topLabel.font=UIFont(name:"Arial",size:15)
        topLabel.textColor=UIColor.whiteColor()
        controller.view.addSubview(topLabel)
    }
    
    
    /**
    *  用户数据载入
    */
    func loadData(_controller: LoginController)
    {
        var url = "http://mm.nextsystem.pw/users-all?page=1&pagesize=30" //接口url
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            if data as NSObject == NSNull(){
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            
            var arr = data["data"] as NSArray //获取返回的数据list数组
            for data : AnyObject  in arr{ //遍历保存数据
                self.dataArray.addObject(data)
            }
            _controller.dataArray=self.dataArray
            GetUserList(_controller:_controller,_scrollView: self.scrollView,_dataArray:self.dataArray)
            })
    }
}

class GetUserList{
    var scrollView:UIScrollView!
    var dataArray = NSMutableArray() //用户数据
    var bodyController:LoginController!
    
    init(_controller: LoginController,_scrollView:UIScrollView,_dataArray:NSMutableArray){
        self.scrollView=_scrollView
        self.dataArray=_dataArray
        self.bodyController=_controller
        
        setUserList()
    }
    
    func setUserList(){
        var dataLen=self.dataArray.count
        for i in 0..dataLen{
            var data = self.dataArray[i] as NSDictionary
            //设置顶部背景
            var topValue=CGFloat(Int(i/3)*100)
            var leftValue=CGFloat((i%3)*100+10)
            var uesrBox = UIButton(frame:CGRectMake(leftValue, topValue, 100, 100))
            uesrBox.backgroundColor=UIColor.clearColor()
            uesrBox.tag = i
            uesrBox.addTarget(self.bodyController,action:"loginBtn:",forControlEvents:.TouchUpInside)
            self.scrollView.addSubview(uesrBox)
            
            // 添加圆形头像
            var URL = data.objectForKey("avatar") as String
            var imageButton = UIButton(frame:CGRectMake(15, 5, 70, 70))
            imageButton.tag = i
            creatRoundImage(imageButton,CGRectMake(0, 0, 70, 70),UIImage(),1.5).setImage(URL,placeHolder: UIImage(named: "userDefault"));
            imageButton.addTarget(self.bodyController,action:"loginBtn:",forControlEvents:.TouchUpInside)
            uesrBox.addSubview(imageButton)
            
            var userName = UILabel(frame:CGRectMake(5, 75, 90, 20))
            userName.text = data.objectForKey("uname") as String
            userName.textAlignment = NSTextAlignment.Center
            userName.font = UIFont(name:"Arial",size:11)
            userName.textColor = UIColor.whiteColor()
            uesrBox.addSubview(userName)
            
        }
    }
}


