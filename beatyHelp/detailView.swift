//
//  detailView.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/11/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class DetailViewDraw{
    var scrollView:UIScrollView! //创建滚动并设置尺寸
    
    init(_controller: DetailsController){
        GetUIBaseView(_controller: _controller)
        GetHeadBar(_controller: _controller, _title: "任务详情")
        setScrollView(_controller)
        GetDetailView(_scrollView: scrollView, _controller: _controller)
    }
    
    func setScrollView(_controller:DetailsController){
        scrollView = UIScrollView(frame:CGRectMake(0, 60, 320, UIScreen.mainScreen().applicationFrame.height-40))
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
    
    var commentListBg:UIView!  //创建框体并设置尺寸
    var topValueBg:UIView! //创建图片并设置尺寸
    var topTitle:UILabel! //创建顶部title
    var commentField:UITextField! //评论输入框
    var commentBtn:UIButton! //评论提交按钮
    var commentListBgArray:UIView[] = []
    let ListNum = 4
    
    var data: NSDictionary!
    var getController: DetailsController!
    
    var arrayDic = getDictionary("list") as NSArray
    var rowNo = 1
    var detailsArray = ["detailsTopBgRed","detailsTopBgBlue", "detailsTopBgRed", "detailsTopBgGreen"]
    var bgHeight: CGFloat!
    var idNum = 0
    var imageNameIndex = 0
    var status:Int!
    
    init(_scrollView: UIScrollView, _controller: DetailsController){
        getController = _controller
        data = _controller.data
        idNum = _controller.id
        
        self.status=(data.objectForKey("status") as String).toInt()!
        setView(_scrollView)
        var setHeight = bgHeight + CGFloat(50*ListNum) + 143
        // 设置可滚动的区域
        _scrollView.contentSize = CGSizeMake(320, setHeight)
    }
    
    func setView(scrollView: UIScrollView){
        setTopBg(scrollView)
        setTimeLabel()
        setIconInfo()
        setUserView()
        setNameLabel()
        setStateLabel()
        setTaskInfo()
        getCommentListBg(scrollView)
        getTopValueBg()
        getTopTitle()
        getCommentListBgArray()
        getCommentField()
        setToolbar()
        getCommentBtn()
        getCommentList()
        if self.status == 1{
            getButton(scrollView)
        }else{
            self.commentListBg.frame = CGRectMake(10, bgHeight+12, 300, CGFloat(28+50*(ListNum+1)))
        }
    }
    
    func setTopBg(_scrollView: UIScrollView){
        imageNameIndex = (self.data.objectForKey("tasktype") as String).toInt()!
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
        stateLabel.text = self.arrayDic[self.status].objectForKey("statusLabel") as String
        stateLabel.textAlignment = NSTextAlignment.Center
        stateLabel.font = UIFont(name:"Arial",size:10)
       var statusColor = self.arrayDic[self.status].objectForKey("statusColor") as String
        stateLabel.textColor = getColorFromDictionary(statusColor)
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
        button = GetlargeBtn(_frame : CGRectMake(7, bgHeight+10, 306, 36), _img : img, _title : "让 我 来").button
        button.addTarget(self.getController,action:"detailDoIt:",forControlEvents:.TouchUpInside)
        scrollView.addSubview(button)
    }
    
    func getCommentListBg(scrollView: UIScrollView){
        commentListBg = UIView(frame: CGRectMake(10, bgHeight+54, 300, CGFloat(28+50*(ListNum+1))))
        var layer = commentListBg.layer
        layer.shadowOffset = CGSizeMake(0, 1)
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.05
        scrollView.addSubview(commentListBg)
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
        commentListBg.addSubview(topValueBg)
    }
    
    func getTopTitle(){
        //绘制title的图标和文字
        var titleIcon = UIImageView(frame:CGRectMake(110,7,15,15))
        titleIcon.image = UIImage(named:"detailsIcon")
        topValueBg.addSubview(titleIcon)
        
        topTitle = UILabel(frame: CGRectMake(130, 8, 80, 12))
        topTitle.text = "用户评论:(\(ListNum))"
        topTitle.font = UIFont(name:"Arial",size:12)
        topTitle.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        topTitle.shadowOffset = CGSizeMake(0, 0.5)
        topTitle.textColor = UIColor.whiteColor()
        topValueBg.addSubview(topTitle)
    }
    
    func getCommentListBgArray(){
        for i in 0..ListNum+1 {
            var middleValueBg = UIView(frame:CGRectMake( 0, CGFloat(28+50*i), 300, 50))
            var middleLayer = middleValueBg.layer
            if i%2 == 1{
                middleLayer.backgroundColor = getColorFromDictionary("greyf3").CGColor
            }else{
                middleLayer.backgroundColor = getColorFromDictionary("greyd8").CGColor
            }
            if i == ListNum {
                var middleMaskPath = UIBezierPath(roundedRect: middleValueBg.bounds, byRoundingCorners: UIRectCorner.BottomLeft|UIRectCorner.BottomRight, cornerRadii:CGSizeMake(5, 5))
                var middleMaskLayer = CAShapeLayer()
                middleMaskLayer.frame = middleLayer.bounds
                middleMaskLayer.path = middleMaskPath.CGPath
                middleValueBg.layer.mask = middleMaskLayer
            }
            commentListBgArray.insert(middleValueBg, atIndex: i)
            commentListBg.addSubview(middleValueBg)
        }
    }
    
    func getCommentList(){
        var nameArray = ["刘萌萌","李牛牛","王晓萌","陈琪"]
        var contentArray = ["这个机会给我吧！我每天请吃早饭！","哎，晚了一步呀，不甘心呀！！！","我擦擦，让我来呀！","哎，手速太慢！"]
        var timeArray = ["2014-05-20  13:18","2014-05-20  09:33","2014-05-19  23:29","2014-05-19  22:47"]
        
        for i in 0..ListNum{
            var userImage = UIImageView(frame:CGRectMake(9, 9, 32, 32))
            userImage.image = UIImage(named: "tinyPhoto\(i+1)")
            userImage.layer.cornerRadius = 3
            commentListBgArray[i+1].addSubview(userImage)
            
            var userName = UILabel(frame:CGRectMake(50, 7, 140, 20))
            userName.text = nameArray[i]
            userName.font = UIFont(name:"Arial",size:12)
            userName.textColor = getColorFromDictionary("grey33")
            commentListBgArray[i+1].addSubview(userName)
            
            var content = UILabel(frame:CGRectMake(50, 25, 200, 20))
            content.text = contentArray[i]
            content.font = UIFont(name:"Arial",size:11)
            content.textColor = getColorFromDictionary("grey50")
            commentListBgArray[i+1].addSubview(content)
            
            var time = UILabel(frame:CGRectMake(208, 7, 100, 20))
            time.text = timeArray[i]
            time.font = UIFont(name:"Arial",size:10)
            time.textColor = getColorFromDictionary("grey60")
            commentListBgArray[i+1].addSubview(time)
            
            var reply = UILabel(frame:CGRectMake(263, 25, 30, 20))
            var replyContent = NSMutableAttributedString(string: String("回 复"))
            var contentRange = NSRange(location: 0, length: replyContent.length)
            //        var getStyle = NSUnderlineStyle.StyleSingle
            var getValue = NSNumber(integer:1)
            replyContent.addAttribute(NSUnderlineStyleAttributeName, value: getValue, range: contentRange)
            reply.attributedText = replyContent
            reply.font = UIFont(name:"Arial",size:12)
            reply.textColor = getColorFromDictionary("red")
            commentListBgArray[i+1].addSubview(reply)
        }
    }
    
    func getCommentField(){
        commentField=GetCommentField(_UIView:commentListBgArray[0])
        getController.commentField = commentField
    }
    
    func setToolbar(){
        var toolbarView=UIToolbar(frame:CGRectMake(0, 0, 320,35))
        toolbarView.barStyle=UIBarStyle.Default
        
        //为工具条创建第一个按钮
        var cancelBtn=UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Bordered, target: nil, action:Selector("cancelKeyboard"))
        
        //为工具条创建第二个按钮
        var spaceBtn=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        //为工具条创建第三个按钮
        var finishBtn=UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Done, target: nil, action: Selector("finishKeyboard"))
        
        //为三个按钮创建数组
        var toolBtnArray=NSMutableArray()
        toolBtnArray.addObject(cancelBtn)
        toolBtnArray.addObject(spaceBtn)
        toolBtnArray.addObject(finishBtn)
        
        //为toolbar设置按钮
        toolbarView.items=toolBtnArray
        commentField.inputAccessoryView=toolbarView
    }
    
    func getCommentBtn(){
        var img = UIImage(named: "redBtn")
        img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
        img.accessibilityFrame = CGRectMake(0, 0, 50, 33)
        commentBtn = GetlargeBtn(_frame : CGRectMake(244, 7.5, 50, 33), _img : img, _title : "发 送").button
//        commentBtn.addTarget(self.getController,action:"detailDoIt:",forControlEvents:.TouchUpInside)
        commentListBgArray[0].addSubview(commentBtn)
    }
}



class GetCommentField:UITextField , UITextFieldDelegate{
    init(_UIView:UIView){
        super.init(frame:CGRectMake(10, 10, 228,28))
        self.backgroundColor=UIColor.whiteColor()
        self.placeholder="请输入评论内容"
        self.font=UIFont(name:"Arial",size:12)
//        self.delegate = self
        var moneyLayer = self.layer
        moneyLayer.cornerRadius=3;
        moneyLayer.borderWidth = 1
        moneyLayer.borderColor = UIColor(red: 190, green: 195, blue: 199, alpha: 1).CGColor
        self.clearButtonMode=UITextFieldViewMode.WhileEditing
//        self.returnKeyType=UIReturnKeyType.Done
        //        self.keyboardAppearance = .Dark;
//        self.keyboardType=UIKeyboardType.NumberPad
        //        var timeSelect=UIView(frame:CGRectMake(0, 0, 320,100))
        //        timeSelect.backgroundColor=UIColor.blackColor()
        //        var timeSelect=UIDatePicker(frame:CGRectMake(0, 0, 0,0))
        //        self.inputView=timeSelect
        _UIView.addSubview(self)
    }
}