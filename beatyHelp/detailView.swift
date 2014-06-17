//
//  detailView.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/11/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit
class DetailViewDraw{
    var scrollView:UIScrollView! //创建滚动并设置尺寸
    
    init(_controller: DetailsController){
        GetUIBaseView(_controller: _controller)
        GetHeadBar(_controller: _controller, _title: "任务详情")
        setScrollView(_controller)
        var detailView = GetDetailView(_scrollView: scrollView, _controller: _controller)
    }
    
    func setScrollView(_controller:DetailsController){
        scrollView = UIScrollView(frame:CGRectMake(0, 60, 320, UIScreen.mainScreen().applicationFrame.height-60))
        // 设置可滚动的区域
//        scrollView.contentSize = CGSizeMake(320, UIScreen.mainScreen().applicationFrame.height)
        _controller.view.addSubview(scrollView)
    }
}

class GetDetailView{
    var topBg: UIImageView!
    var timeLabel: UILabel!
    var userView: UIImageView!
    var userName: UILabel!
    var stateLabel: UILabel!
    var taskInfo: UILabel!
    var button: UIButton!
    
    var data: NSDictionary!
    var getController: DetailsController!
    
    var arrayDic = getDictionary("list") as NSArray
    var rowNo = 1
    var detailsArray = ["detailsTopBgBlue", "detailsTopBgRed", "detailsTopBgGreen"]
    var bgHeight: CGFloat!
    var idNum = 0
    var imageNameIndex = 0
    
    init(_scrollView: UIScrollView, _controller: DetailsController){
        getController = _controller
        data = _controller.data
        idNum = _controller.id
        
        setView(_scrollView)
    }
    
    func setView(scrollView: UIScrollView){
        setTopBg(scrollView)
        setTimeLabel()
        setIconInfo()
        setUserView()
        setNameLabel()
        setStateLabel()
        setTaskInfo()
        getButton(scrollView)
    }
    
    func setTopBg(_scrollView: UIScrollView){
        imageNameIndex = (self.data.objectForKey("tasktype") as String).toInt()! - 1
        var img = UIImage(named: detailsArray[imageNameIndex]).stretchableImageWithLeftCapWidth(0, topCapHeight:95)
        topBg = UIImageView(image: img)
        topBg.frame = CGRectMake(7, 5, 306 , 145)
        _scrollView.addSubview(topBg)
    }
    
    func setTimeLabel(){
        timeLabel = UILabel(frame:CGRectMake(198, 7, 160, 20))
        timeLabel.text = data.objectForKey("pubdate") as String
        timeLabel.font = UIFont(name:"Arial",size:10)
        timeLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        topBg.addSubview(timeLabel)
    }
    
    func setIconInfo(){
        var iconImage = arrayDic[imageNameIndex].objectForKey("taskIcon") as String
        var nameLabel = arrayDic[imageNameIndex].objectForKey("taskName") as String
        
        var taskIcon = UIImageView(image: UIImage(named:iconImage))
        taskIcon.frame = CGRectMake(75, 7, 20, 20)
        topBg.addSubview(taskIcon)
        
        var taskName = UILabel(frame:CGRectMake(97, 6, 45, 20))
        taskName.text = nameLabel
        taskName.font = UIFont(name:"Arial",size:12)
        taskName.textColor = UIColor.whiteColor()
        taskName.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        taskName.shadowOffset = CGSizeMake(0, 0.5)
        topBg.addSubview(taskName)
        
        var taskLine = UIView(frame:CGRectMake(136, 9, 1, 14))
        taskLine.backgroundColor = UIColor.whiteColor()
        topBg.addSubview(taskLine)
        
        var goldIcon =  UIImageView(image: UIImage(named: "icon05"))
        goldIcon.frame = CGRectMake(141, 7, 20, 20)
        topBg.addSubview(goldIcon)
        
        var goldValue = UILabel(frame:CGRectMake(150, 6, 40, 20))
        goldValue.text = data.objectForKey("coin") as String
        goldValue.textAlignment = NSTextAlignment.Center
        goldValue.font = UIFont(name:"Arial",size:12)
        goldValue.textColor = UIColor.whiteColor()
        goldValue.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        goldValue.shadowOffset = CGSizeMake(0, 0.5)
        topBg.addSubview(goldValue)
    }
    
    func setUserView(){
        var URL = data.objectForKey("avatar") as String
        var imageButton = UIButton(frame:CGRectMake(3, 2.5, 64, 64))
        imageButton.addTarget(self.getController,action:"otherImage:",forControlEvents:.TouchUpInside)
        // 添加圆形头像
        creatRoundImage(imageButton,CGRectMake(0, 0, 64, 64),UIImage(),1.5).setImage(URL,placeHolder: UIImage(named: "userList01.jpg"));
        topBg.addSubview(imageButton)
    }
    
    func setNameLabel(){
        userName = UILabel(frame:CGRectMake(2, 71, 70, 20))
        userName.text = data.objectForKey("uname") as String
        userName.textAlignment = NSTextAlignment.Center
        userName.font = UIFont(name:"Arial",size:11)
        userName.textColor = getColorFromDictionary("grey33")
        topBg.addSubview(userName)
        topBg.userInteractionEnabled = true
    }
    
    func setStateLabel(){
        stateLabel = UILabel(frame:CGRectMake(2, 94, 70, 20))
        stateLabel.text = "任务已领取"
        stateLabel.textAlignment = NSTextAlignment.Center
        stateLabel.font = UIFont(name:"Arial",size:10)
        stateLabel.textColor = getColorFromDictionary("greenT")
        topBg.addSubview(stateLabel)
    }
    
    func setTaskInfo(){
        var infoLabel = data.objectForKey("intro") as String
        taskInfo = UILabel(frame:CGRectMake(75, 35, 224, 55))
        taskInfo.text = infoLabel
        taskInfo.font = UIFont(name:"Arial",size:12)
        taskInfo.textColor = getColorFromDictionary("grey50")
        var height = infoLabel.stringHeightWith(12,width:224)
        var textHeight: CGFloat!
        if(height <= 300 && height >= 78){
            textHeight = height
            bgHeight = height+40
        }else if(height > 300){
            textHeight = 300
            bgHeight = height+40
        }else if(height < 78){
            textHeight = height
            bgHeight = 118
        }
        taskInfo.setHeight(textHeight)
        topBg.setHeight(bgHeight)
        //自动折行设置
        taskInfo.lineBreakMode = .ByWordWrapping
        taskInfo.numberOfLines = 0
        topBg.addSubview(taskInfo)
    }
    
    func getButton(scrollView: UIScrollView){
        var img = UIImage(named: "blueBtn")
        img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
        img.accessibilityFrame = CGRectMake(0, 0, 304, 36)
        button = GetlargeBtn(_frame : CGRectMake(7, bgHeight+10, 306, 36), _img : img, _title : "让 我 来！").button
        scrollView.addSubview(button)
    }
}