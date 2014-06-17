//
//  mainView.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/6/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class MainViewDraw{
    init(_controller:ViewController){
        // 为controller添加baseView
        GetUIBaseView(_controller: _controller)
        GetMainViewTop(_controller: _controller,_pageNum: 1)
        GetMainViewMiddle(_controller: _controller)
        GetFootBar(_controller: _controller, _index: 1)
    }
}

class GetMainViewTop{
    var topValueBg:UIImageView! // 顶部框体包括背景图
    var userImage:UIImageView! // 顶部用户头像
    var userName:UILabel! // 顶部用户名
    var userSign:UILabel! // 顶部用户签名
    var labelArray:UILabel[] = [] //顶部按钮goldIcon,upIcon,downIcon数值
    var phoneIcon:UIImageView!
    var phoneNum:UILabel!
    
    init(_controller:UIViewController, _pageNum:Int){
        setTopValueBg(_controller)
        setUserImage()
        setUserName()
        setUserSign()
        if _pageNum == 1 {
            setLabelArray()
        }
        else if _pageNum == 2{
            setPhoneIcon()
            setPhoneNum()
        }
    }
    
    func setTopValueBg(controller:UIViewController){
        // 创建框体并设置尺寸
        topValueBg = UIImageView(frame:CGRectMake(0,20,320,108))
        //根据图片名，确定图片引用
        topValueBg.image = UIImage(named:"topBgImg.jpg")
        // 将圆图添加到UIView上
        controller.view.addSubview(topValueBg)
    }
    
    func setUserImage(){
        // 在plist文件中获取用户头像信息
        var str2 = getDictionary("userInfo").objectForKey("headImage") as NSString
        // 添加圆形头像
        userImage = creatRoundImage(topValueBg,CGRectMake(20,15,78,78),str2,3.0);
    }
    
    func setUserName(){
        userName = UILabel(frame:CGRectMake(110, 20, 200, 20))
        userName.text = toString(getDictionary("userInfo").objectForKey("userName"))
        userName.font = UIFont(name:"Arial",size:20)
        userName.textColor = UIColor.whiteColor()
        userName.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        userName.shadowOffset = CGSizeMake(0, 0.5)
        topValueBg.addSubview(userName)
    }
    
    func setUserSign(){
        userSign = UILabel(frame:CGRectMake(110, 45, 200, 20))
        userSign.text = toString(getDictionary("userInfo").objectForKey("userSign"))
        userSign.font = UIFont(name:"Arial",size:14)
        userSign.textColor = UIColor.whiteColor()
        userSign.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        userSign.shadowOffset = CGSizeMake(0, 0.5)
        topValueBg.addSubview(userSign)
    }
    
    func setLabelArray(){
        //创建需要在顶部添加的图片名称数组
        var topIconArray = ["goldIcon","upIcon","downIcon"]
        //创建需要在顶部添加的数值数组
        var labelTextArray = getDictionary("userInfo").objectForKey("iconValue") as NSArray
        
        for i in 0..topIconArray.count{
            // 添加圆形icon
            creatRoundImage(topValueBg,CGRectMake(CGFloat(106+i*68),70,21,21),topIconArray[i],1.5);
            //初始化label的尺寸
            var label = UILabel(frame:CGRectMake(CGFloat(131+i*68), 72, 0, 0))
            //获取文案
            var str = toString(labelTextArray[i])
            //设置文案
            label.text = str
            //设置文案颜色
            label.textColor = UIColor.whiteColor()
            //设置文案背景色，以及0.7透明
            label.backgroundColor = UIColor(red:0,green:0,blue:0,alpha:0.7)
            //设置文字居中
            label.textAlignment = NSTextAlignment.Center
            //设置文字字体以及字体大小
            label.font = UIFont(name:"Arial",size:12)
            //设置边框以及是否可见
            label.layer.masksToBounds = true
            //设置圆角尺寸
            label.layer.cornerRadius = 10.0
            //设置label宽高，使其根据文字内容自适应
            label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y,CGFloat(12/2*countElements(str)+14), 12+4)
            labelArray.insert(label, atIndex: i)
            topValueBg.addSubview(label)
        }
    }
    
    func setPhoneIcon(){
        // 创建框体并设置尺寸
        phoneIcon = UIImageView(frame:CGRectMake(110,73,9,13))
        //根据图片名，确定图片引用
        phoneIcon.image = UIImage(named:"phoneIcon")
        // 将圆图添加到UIView上
        topValueBg.addSubview(phoneIcon)
    }
    
    func setPhoneNum(){
        phoneNum = UILabel(frame:CGRectMake(122, 68, 97, 21))
        phoneNum.text = toString(getDictionary("userInfo").objectForKey("phoneNum"))
        phoneNum.font = UIFont(name:"Arial",size:12)
        phoneNum.textColor = UIColor.whiteColor()
        phoneNum.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        phoneNum.shadowOffset = CGSizeMake(0, 0.5)
        topValueBg.addSubview(phoneNum)
    }
}

class GetMainViewMiddle{
    var lineImgView:UIImageView! // 筛选栏
    var imgBtnView:UIImageView! // 按钮
    
    init(_controller:UIViewController){
        setLineImgView(_controller)
        setImgBtnView(_controller)
    }
    
    func setLineImgView(controller:UIViewController){
        //创建图片并设置引用,根据宽高设置拉伸图片
        var lineImg = UIImage(named:"middleLine").stretchableImageWithLeftCapWidth(4,topCapHeight: 0)
        //根据拉伸后的图片创建imageView
        lineImgView = UIImageView(image:lineImg)
        //设置尺寸和位置
        lineImgView.frame = CGRectMake(0, 128, 234, 31)
        controller.view.addSubview(lineImgView)
    }
    
    func setImgBtnView(controller:UIViewController){
        var createBtn = UIButton(frame:CGRectMake(229, 128, 90, 32))
        var btnImg = UIImage(named:"middleBtn").stretchableImageWithLeftCapWidth(13,topCapHeight: 0)
        createBtn.setBackgroundImage(btnImg, forState: UIControlState.Normal)
        controller.view.addSubview(createBtn)
        
        var btnIcon = UIImageView(image: UIImage(named:"icon01"))
        btnIcon.frame = CGRectMake(11, 5, 20, 20)
        createBtn.addSubview(btnIcon)
        
        var btnLabel = UILabel(frame:CGRectMake(33, 5, 45, 20))
        btnLabel.text = "发任务"
        btnLabel.font = UIFont(name:"Arial",size:15)
        btnLabel.textColor = UIColor.whiteColor()
        btnLabel.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        btnLabel.shadowOffset = CGSizeMake(0, 0.5)
        createBtn.addSubview(btnLabel)
        createBtn.addTarget(controller,action:"createAction:",forControlEvents:.TouchUpInside);
    }
}

class GetTableView{
    var cell:UITableViewCell!
    var timeLabel:UILabel!
    var imgView:UIImageView!
    var buttonArray:UIImageView[] = []
    
    init(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!){
        var arrayDic = getDictionary("list") as NSArray
        var rowNo = indexPath.row
        var identifier = arrayDic[rowNo%3].objectForKey("identifier") as String
        var imageName = arrayDic[rowNo%3].objectForKey("imageName") as String
        var dateText = arrayDic[rowNo%3].objectForKey("time") as String
        var userImage = arrayDic[rowNo%3].objectForKey("userImage") as String
        var iconImage = arrayDic[rowNo%3].objectForKey("taskIcon") as String
        var nameLabel = arrayDic[rowNo%3].objectForKey("taskName") as String
        var goldLabel = arrayDic[rowNo%3].objectForKey("gold") as String
        var userLabel = arrayDic[rowNo%3].objectForKey("userName") as String
        var infoLabel = arrayDic[rowNo%3].objectForKey("taskInfo") as String
    
        cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath:indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
    
        var img = UIImage(named:imageName).stretchableImageWithLeftCapWidth(0, topCapHeight:70)
        imgView = UIImageView(image:img)
        imgView.frame = CGRectMake(0, 10, 306 , 135)
        cell.addSubview(imgView)
        
        var taskIcon = UIImageView(image: UIImage(named:iconImage))
        taskIcon.frame = CGRectMake(75, 14, 20, 20)
        cell.addSubview(taskIcon)
        
        var taskName = UILabel(frame:CGRectMake(97, 13, 45, 20))
        taskName.text = nameLabel
        taskName.font = UIFont(name:"Arial",size:12)
        taskName.textColor = UIColor.whiteColor()
        taskName.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        taskName.shadowOffset = CGSizeMake(0, 0.5)
        cell.addSubview(taskName)
        
        var taskLine = UIView(frame:CGRectMake(136, 16, 1, 14))
        taskLine.backgroundColor = UIColor.whiteColor()
        cell.addSubview(taskLine)
        
        var goldIcon =  UIImageView(image: UIImage(named: "icon05"))
        goldIcon.frame = CGRectMake(141, 14, 20, 20)
        cell.addSubview(goldIcon)
        
        var goldValue = UILabel(frame:CGRectMake(150, 13, 40, 20))
        goldValue.text = goldLabel
        goldValue.textAlignment = NSTextAlignment.Center
        goldValue.font = UIFont(name:"Arial",size:12)
        goldValue.textColor = UIColor.whiteColor()
        goldValue.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        goldValue.shadowOffset = CGSizeMake(0, 0.5)
        cell.addSubview(goldValue)
        
        var userName = UILabel(frame:CGRectMake(0, 79, 70, 20))
        userName.text = userLabel
        userName.textAlignment = NSTextAlignment.Center
        userName.font = UIFont(name:"Arial",size:11)
        userName.textColor = getColorFromDictionary("grey33")
        cell.addSubview(userName)
        
        var taskInfo = UILabel(frame:CGRectMake(75, 43, 224, 55))
        taskInfo.text = infoLabel
        taskInfo.font = UIFont(name:"Arial",size:12)
        taskInfo.textColor = getColorFromDictionary("grey50")
        var height = infoLabel.stringHeightWith(12,width:224)
        taskInfo.setHeight(height <= 55 ? height : 55)
        //自动折行设置
        taskInfo.lineBreakMode = .ByWordWrapping
        taskInfo.numberOfLines = 0
        cell.addSubview(taskInfo)
        
        for i in 0..3{
            var buttonBg = UIImageView()
            buttonBg.frame = CGRectMake(CGFloat(101*i+2), cell.height()-30, 100, 30)
            
            var buttonIcon =  UIImageView(image: UIImage(named: "greyIcon0\(i+1)"))
            buttonIcon.frame = CGRectMake(40, 5, 20, 20)
            buttonBg.addSubview(buttonIcon)
            
            buttonArray.insert(buttonBg, atIndex: i)
            cell.addSubview(buttonBg)
        }
    
        timeLabel = UILabel(frame:CGRectMake(198, 14, 160, 20))
        timeLabel.text = dateText
        timeLabel.font = UIFont(name:"Arial",size:10)
        timeLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        cell.addSubview(timeLabel)
        // 添加圆形头像
        creatRoundImage(cell,CGRectMake(3, 9, 64, 64),userImage,1.5);
    }
}

