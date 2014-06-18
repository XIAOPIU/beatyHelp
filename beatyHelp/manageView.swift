//
//  manageView.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class ManageViewDraw{
    var leftTab:UIButton! // 发布的任务
    var rightTab:UIButton! //领取的任务
    
    init(_controller: ManageController){
        GetUIBaseView(_controller: _controller)
        GetFootBar(_controller: _controller, _index: 2)
        var topView=GetTopTab(_controller: _controller)
        leftTab=topView.leftTab
        rightTab=topView.rightTab
    }
}

class GetTopTab{
    var topTab:UIView! // 创建顶部Tab
    var leftTab:UIButton! // 发布的任务
    var rightTab:UIButton! //领取的任务
    var separator:UIImageView! //tab中间的分隔线
    var bottomLine:UIImageView! //底部分隔线
    
    init(_controller:UIViewController){
        setTopTab(_controller)
        setSeparator()
        setLeftTab(_controller)
        setRightTab(_controller)
    }
    
    //创建顶部Tab框体并设置尺寸
    func setTopTab (controller:UIViewController){
        topTab = UIView(frame:CGRectMake(10, 20, 300, 42))
        var layer = topTab.layer
        controller.view.addSubview(topTab)
    }
    
    //绘制顶部tab中间和底部的分隔线
    func setSeparator(){
        separator=UIImageView(frame:CGRectMake(149,13,1,18))
        separator.image = UIImage(named:"separator")
        topTab.addSubview(separator)
        
        bottomLine=UIImageView(frame:CGRectMake(0,39,300,2.5))
        bottomLine.image = UIImage(named:"bottomLine")
        topTab.addSubview(bottomLine)
    }
    
    //绘制左侧tab
    func setLeftTab(controller:UIViewController){
        leftTab = UIButton(frame:CGRectMake(15, 11, 120, 20))
        var tabIcon = UIImageView(frame:CGRectMake(0,0,18,17))
        var tabLabel=UILabel(frame:CGRectMake(20, 0, 120, 20))
        tabIcon.image = UIImage(named:"leftTabIcon")
        tabLabel.text="发布的任务(21)"
        tabLabel.font=UIFont(name:"Arial",size:13)
        tabLabel.textColor=UIColor.whiteColor()
        
        leftTab.addSubview(tabIcon)
        leftTab.addSubview(tabLabel)
        topTab.addSubview(leftTab)
        leftTab.addTarget(controller,action:"leftTabAction:",forControlEvents:.TouchUpInside);
    }
    
    //绘制右侧tab
    func setRightTab(controller:UIViewController){
        rightTab = UIButton(frame:CGRectMake(165, 11, 120, 20))
        var tabIcon = UIImageView(frame:CGRectMake(0,0,18,17))
        var tabLabel=UILabel(frame:CGRectMake(20, 0, 120, 20))
        tabIcon.image = UIImage(named:"rightTabIcon")
        tabLabel.text="领取的任务(21)"
        tabLabel.font=UIFont(name:"Arial",size:13)
        tabLabel.textColor=UIColor.whiteColor()
        rightTab.alpha=0.5
        rightTab.addTarget(controller,action:"rightTabAction:",forControlEvents:.TouchUpInside);
        rightTab.addSubview(tabIcon)
        rightTab.addSubview(tabLabel)
        topTab.addSubview(rightTab)
    }
}

class GetPubTableView{
    var cell:UITableViewCell!
    var statusLabel:UILabel!
    var schoolLabel:UILabel!
    var telLabel:UILabel!
    var commonFriLabel:UILabel!
    var imgView:UIImageView!
    var mainTable:UITableView!
    var cellIndex:NSIndexPath!
    var tabIndex:Int
    var data :NSDictionary!
    
    init(tableView: UITableView!, indexPath: NSIndexPath!,tableIndex:Int){
        mainTable=tableView
        cellIndex=indexPath
        tabIndex=tableIndex
        drawCell(tableView, indexPath: indexPath!,tableIndex: tableIndex)
        println(data)
    }
    
    func drawCell(tableView: UITableView!, indexPath: NSIndexPath!,tableIndex: Int){
        var arrayDic = getDictionary("publist") as NSArray
        var rowNo = indexPath.row
        var identifier = arrayDic[rowNo%3].objectForKey("identifier") as String
        var imageName = arrayDic[rowNo%3].objectForKey("imageName") as String
        var statusText = arrayDic[rowNo%3].objectForKey("statusLabel") as String
        var statusColor = arrayDic[rowNo%3].objectForKey("statusColor") as String
        var status=arrayDic[rowNo%3].objectForKey("status") as Int
        var school=arrayDic[rowNo%3].objectForKey("school") as String
        var academy=arrayDic[rowNo%3].objectForKey("academy") as String
        var commonFri=arrayDic[rowNo%3].objectForKey("commonFri") as NSArray
        var tel=arrayDic[rowNo%3].objectForKey("tel") as String
        var commenFriNum=commonFri.count
        var commenFriTitle="你们的共同好友有 \(commenFriNum) 位"
        var userImage:String
        if tableIndex==0{
            userImage = arrayDic[rowNo%3].objectForKey("userImage") as String
        }
        else{
            userImage = arrayDic[(rowNo+1)%3].objectForKey("userImage") as String
        }
        
        cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath:indexPath) as UITableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        var img = UIImage(named:imageName).stretchableImageWithLeftCapWidth(0, topCapHeight:70)
        imgView = UIImageView(image:img)
        imgView.frame = CGRectMake(0, 10, 306 , 160)
        cell.addSubview(imgView)
        
        var iconImage=arrayDic[rowNo%3].objectForKey("taskIcon") as String
        var taskIcon = UIImageView(image: UIImage(named:iconImage))
        taskIcon.frame = CGRectMake(75, 14, 20, 20)
        cell.addSubview(taskIcon)
        
        var taskName = UILabel(frame:CGRectMake(97, 13, 45, 20))
        taskName.text = arrayDic[rowNo%3].objectForKey("taskName") as String
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
        goldValue.text = arrayDic[rowNo%3].objectForKey("gold") as String
        goldValue.textAlignment = NSTextAlignment.Center
        goldValue.font = UIFont(name:"Arial",size:12)
        goldValue.textColor = UIColor.whiteColor()
        goldValue.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        goldValue.shadowOffset = CGSizeMake(0, 0.5)
        cell.addSubview(goldValue)
        
        var userName = UILabel(frame:CGRectMake(0, 79, 70, 20))
        userName.text = arrayDic[rowNo%3].objectForKey("userName") as String
        userName.textAlignment = NSTextAlignment.Center
        userName.font = UIFont(name:"Arial",size:11)
        userName.textColor = getColorFromDictionary("grey33")
        cell.addSubview(userName)
        
        //状态文案
        statusLabel = UILabel(frame:CGRectMake(218, 14, 160, 20))
        statusLabel.text = statusText
        statusLabel.font = UIFont(name:"Arial",size:12)
        statusLabel.textColor = getColorFromDictionary(statusColor)
        cell.addSubview(statusLabel)
        
        //学校和学院文案
        schoolLabel = UILabel(frame:CGRectMake(75, 40, 217, 15))
        schoolLabel.text = "\(school) \(academy)"
        schoolLabel.font = UIFont(name:"Arial",size:11)
        schoolLabel.textColor = UIColor.blackColor()
        cell.addSubview(schoolLabel)
        
        //电话号码图标
        var mobileIcon = UIImage(named:"mobileIcon")
        imgView = UIImageView(image:mobileIcon)
        imgView.frame = CGRectMake(220, 57, 6 , 10)
        cell.addSubview(imgView)
        
        //电话号码文案
        telLabel = UILabel(frame:CGRectMake(229, 55, 217, 15))
        telLabel.text = tel
        telLabel.font = UIFont(name:"Arial",size:10)
        telLabel.textColor = UIColor.blackColor()
        cell.addSubview(telLabel)
        
        
        //共同好友文案
        commonFriLabel = UILabel(frame:CGRectMake(75, 55, 217, 15))
        commonFriLabel.text = commenFriTitle
        commonFriLabel.font = UIFont(name:"Arial",size:10)
        commonFriLabel.textColor = UIColor.blackColor()
        cell.addSubview(commonFriLabel)
        
        //共同好友照片
        for i in 0..commenFriNum{
            var photoName=commonFri[i].objectForKey("photo") as String
            var img = UIImage(named:photoName)
            imgView = UIImageView(image:img)
            imgView.frame = CGRectMake(CGFloat(75+i*37), 73, 32 , 32)
            cell.addSubview(imgView)
        }
        
        //领取时间文案
        var getTime=arrayDic[rowNo%3].objectForKey("getTime") as String
        var getTimeText="领取时间 |  \(getTime)"
        var getTimeLabel = UILabel(frame:CGRectMake(15, 110, 135, 12))
        getTimeLabel.text = getTimeText
        getTimeLabel.font = UIFont(name:"Arial",size:10)
        getTimeLabel.textColor = UIColor.grayColor()
        cell.addSubview(getTimeLabel)
        
        //领取时间文案
        var limitTime=arrayDic[rowNo%3].objectForKey("limitTime") as String
        var limitTimeText="有效时间 |  \(limitTime)"
        var limitTimeLabel = UILabel(frame:CGRectMake(160, 110, 135, 12))
        limitTimeLabel.text = limitTimeText
        limitTimeLabel.font = UIFont(name:"Arial",size:10)
        limitTimeLabel.textColor = UIColor.grayColor()
        cell.addSubview(limitTimeLabel)
        
        // 添加圆形头像
        creatRoundImage(cell,CGRectMake(3, 9, 64, 64),UIImage(named:userImage),1.5);
        
        setBottom(status)
    }
    
    func setBottom(status:Int){
        //查看icon
        var previewIcon = UIImage(named:"previewIcon")
        var previewImgView = UIImageView(image:previewIcon)
        previewImgView.frame = CGRectMake(56, 8, 15 , 13)
        
        //查看文案
        var previewLabel = UILabel(frame:CGRectMake(75, 8, 25, 13))
        previewLabel.text = "查看"
        previewLabel.font = UIFont(name:"Arial",size:12)
        previewLabel.textColor = UIColor.grayColor()
        
        //终止icon
        var stopIcon = UIImage(named:"stopIcon")
        var stopImgView = UIImageView(image:stopIcon)
        stopImgView.frame = CGRectMake(56, 8, 15 , 13)
        
        //stop文案
        var stopLabel = UILabel(frame:CGRectMake(75, 8, 25, 13))
        stopLabel.text = "终止"
        stopLabel.font = UIFont(name:"Arial",size:12)
        stopLabel.textColor = UIColor.grayColor()
//
        //评价icon
        var commentIcon = UIImage(named:"pubCommentIcon")
        var commentImgView = UIImageView(image:commentIcon)
        commentImgView.frame = CGRectMake(40, 8, 15 , 13)
        
        //comment文案
        var commentLabel = UILabel(frame:CGRectMake(59, 8, 65, 13))
        commentLabel.text = "评价发布人"
        commentLabel.font = UIFont(name:"Arial",size:12)
        commentLabel.textColor = UIColor.grayColor()
        
        if status==2{
            var leftBtn=UIButton(frame:CGRectMake(2, 130, 150, 28))
            leftBtn.addSubview(previewImgView)
            leftBtn.addSubview(previewLabel)
            cell.addSubview(leftBtn)
            
            var middleLine=UIView(frame:CGRectMake(150, 135, 1, 20))
            middleLine.backgroundColor=UIColor.grayColor()
            middleLine.alpha=0.3
            cell.addSubview(middleLine)
            
            var rightBtn=UIButton(frame:CGRectMake(152, 130, 150, 28))
            rightBtn.addSubview(stopImgView)
            rightBtn.addSubview(stopLabel)
            cell.addSubview(rightBtn)
        }
        else if status==3{
            var leftBtn=UIButton(frame:CGRectMake(2, 130, 150, 28))
            leftBtn.addSubview(previewImgView)
            leftBtn.addSubview(previewLabel)
            cell.addSubview(leftBtn)
            
            var middleLine=UIView(frame:CGRectMake(150, 135, 1, 20))
            middleLine.backgroundColor=UIColor.grayColor()
            middleLine.alpha=0.3
            cell.addSubview(middleLine)
            
            var rightBtn=UIButton(frame:CGRectMake(152, 130, 150, 28))
            rightBtn.addSubview(commentImgView)
            rightBtn.addSubview(commentLabel)
            cell.addSubview(rightBtn)
        }
        else if status==0{
            var leftBtn=UIButton(frame:CGRectMake(2, 130, 300, 28))
            leftBtn.addSubview(previewImgView)
            leftBtn.addSubview(previewLabel)
            previewImgView.setX(130)
            previewLabel.setX(150)
            cell.addSubview(leftBtn)
        }
    }
}

class GetPubTabelCell:UITableViewCell{
    var imgView:UIImageView!
    var buttonArray:UIButton[] = []
    var data :NSDictionary!
    var status:Int!
    
    var getController:UIViewController!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        var arrayDic = getDictionary("publist") as NSArray
        var imageNameIndex = (data.objectForKey("tasktype") as String).toInt()! - 1
        var imageName = arrayDic[imageNameIndex].objectForKey("imageName") as String
        var iconImage = arrayDic[imageNameIndex].objectForKey("taskIcon") as String
        var nameLabel = arrayDic[imageNameIndex].objectForKey("taskName") as String
        
        var img = UIImage(named:imageName).stretchableImageWithLeftCapWidth(0, topCapHeight:70)
        imgView = UIImageView(image:img)
        imgView.frame = CGRectMake(0, 10, 306 , 160)
        self.addSubview(imgView)
        
        var taskIcon = UIImageView(image: UIImage(named:iconImage))
        taskIcon.frame = CGRectMake(75, 14, 20, 20)
        self.addSubview(taskIcon)
        
        var taskName = UILabel(frame:CGRectMake(97, 13, 45, 20))
        taskName.text = nameLabel
        taskName.font = UIFont(name:"Arial",size:12)
        taskName.textColor = UIColor.whiteColor()
        taskName.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        taskName.shadowOffset = CGSizeMake(0, 0.5)
        self.addSubview(taskName)
        
        var taskLine = UIView(frame:CGRectMake(136, 16, 1, 14))
        taskLine.backgroundColor = UIColor.whiteColor()
        self.addSubview(taskLine)
        
        var goldIcon =  UIImageView(image: UIImage(named: "icon05"))
        goldIcon.frame = CGRectMake(141, 14, 20, 20)
        self.addSubview(goldIcon)
        
        var goldValue = UILabel(frame:CGRectMake(150, 13, 40, 20))
        goldValue.text = data.objectForKey("coin") as String
        goldValue.textAlignment = NSTextAlignment.Center
        goldValue.font = UIFont(name:"Arial",size:12)
        goldValue.textColor = UIColor.whiteColor()
        goldValue.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        goldValue.shadowOffset = CGSizeMake(0, 0.5)
        self.addSubview(goldValue)
        
        var userName = UILabel(frame:CGRectMake(0, 79, 70, 20))
        userName.text = data.objectForKey("uname") as String
        userName.textAlignment = NSTextAlignment.Center
        userName.font = UIFont(name:"Arial",size:11)
        userName.textColor = getColorFromDictionary("grey33")
        self.addSubview(userName)
        
        //状态文案
        self.status=(data.objectForKey("status") as String).toInt()!
        var statusText = arrayDic[self.status].objectForKey("statusLabel") as String
        var statusColor = arrayDic[self.status].objectForKey("statusColor") as String
        var statusLabel = UILabel(frame:CGRectMake(218, 14, 160, 20))
        statusLabel.text = statusText
        statusLabel.font = UIFont(name:"Arial",size:12)
        statusLabel.textColor = getColorFromDictionary(statusColor)
        self.addSubview(statusLabel)
        
        //学校文案
        var school=data.objectForKey("school") as String
        var schoolLabel = UILabel(frame:CGRectMake(75, 40, 217, 15))
        schoolLabel.text=school
        schoolLabel.font = UIFont(name:"Arial",size:11)
        schoolLabel.textColor = UIColor.blackColor()
        self.addSubview(schoolLabel)
        
        setBottom()
//        var infoLabel = data.objectForKey("intro") as String
//        var taskInfo = UILabel(frame:CGRectMake(75, 43, 224, 55))
//        taskInfo.text = infoLabel
//        taskInfo.font = UIFont(name:"Arial",size:12)
//        taskInfo.textColor = getColorFromDictionary("grey50")
//        var height = infoLabel.stringHeightWith(12,width:224)
//        taskInfo.setHeight(height <= 55 ? height : 55)
//        //自动折行设置
//        taskInfo.lineBreakMode = .ByWordWrapping
//        taskInfo.numberOfLines = 0
//        self.addSubview(taskInfo)
        
//        for i in 0..3{
//            
//            var buttonView = UIButton()
//            buttonView.frame = CGRectMake(CGFloat(101*i+2), self.height()-30, 100, 30)
//            var buttonBg = UIImageView()
//            buttonBg.frame = CGRectMake(0, 0, 100, 30)
//            
//            var buttonIcon =  UIImageView(image: UIImage(named: "greyIcon0\(i+1)"))
//            buttonIcon.frame = CGRectMake(40, 5, 20, 20)
//            buttonView.addTarget(self.getController, action:"cellBottomEvent:", forControlEvents:.TouchUpInside)
//            buttonView.tag = i
//            
//            if i != 2 {
//                var middleLine=UIView(frame:CGRectMake(CGFloat(101*(i+1)+3), self.height()-25, 1, 20))
//                middleLine.backgroundColor=UIColor.grayColor()
//                middleLine.alpha=0.3
//                self.addSubview(middleLine)
//            }
//            
//            buttonArray.insert(buttonView, atIndex: i)
//            buttonBg.addSubview(buttonIcon)
//            buttonView.addSubview(buttonBg)
//            self.addSubview(buttonView)
//            //            self.userInteractionEnabled = true
//        }
        
//        timeLabel = UILabel(frame:CGRectMake(198, 14, 160, 20))
//        timeLabel.text = data.objectForKey("pubdate") as String
//        timeLabel.font = UIFont(name:"Arial",size:10)
//        timeLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
//        self.addSubview(timeLabel)
        
        var URL = data.objectForKey("avatar") as String
        var imageButton = UIButton(frame:CGRectMake(3, 9, 64, 64))
        imageButton.addTarget(self,action:"otherImage:",forControlEvents:.TouchUpInside)
        // 添加圆形头像
        creatRoundImage(imageButton,CGRectMake(0, 0, 64, 64),UIImage(),1.5).setImage(URL,placeHolder: UIImage(named: "userList01.jpg"));
        self.addSubview(imageButton)
    }
    
    func setBottom(){
        //查看icon
        var previewIcon = UIImage(named:"previewIcon")
        var previewImgView = UIImageView(image:previewIcon)
        previewImgView.frame = CGRectMake(56, 8, 15 , 13)
        
        //查看文案
        var previewLabel = UILabel(frame:CGRectMake(75, 8, 25, 13))
        previewLabel.text = "查看"
        previewLabel.font = UIFont(name:"Arial",size:12)
        previewLabel.textColor = UIColor.grayColor()
        
        //终止icon
        var stopIcon = UIImage(named:"stopIcon")
        var stopImgView = UIImageView(image:stopIcon)
        stopImgView.frame = CGRectMake(56, 8, 15 , 13)
        
        //stop文案
        var stopLabel = UILabel(frame:CGRectMake(75, 8, 25, 13))
        stopLabel.text = "终止"
        stopLabel.font = UIFont(name:"Arial",size:12)
        stopLabel.textColor = UIColor.grayColor()
        //
        //评价icon
        var commentIcon = UIImage(named:"pubCommentIcon")
        var commentImgView = UIImageView(image:commentIcon)
        commentImgView.frame = CGRectMake(40, 8, 15 , 13)
        
        //comment文案
        var commentLabel = UILabel(frame:CGRectMake(59, 8, 65, 13))
        commentLabel.text = "评价发布人"
        commentLabel.font = UIFont(name:"Arial",size:12)
        commentLabel.textColor = UIColor.grayColor()
        
        if self.status==2{
            var leftBtn=UIButton(frame:CGRectMake(2, 130, 150, 28))
            leftBtn.addSubview(previewImgView)
            leftBtn.addSubview(previewLabel)
            leftBtn.addTarget(self,action:"preview:",forControlEvents:.TouchUpInside)
            self.addSubview(leftBtn)
            
            var middleLine=UIView(frame:CGRectMake(150, 135, 1, 20))
            middleLine.backgroundColor=UIColor.grayColor()
            middleLine.alpha=0.3
            self.addSubview(middleLine)
            
            var rightBtn=UIButton(frame:CGRectMake(152, 130, 150, 28))
            rightBtn.addSubview(stopImgView)
            rightBtn.addSubview(stopLabel)
            self.addSubview(rightBtn)
        }
        else if self.status==3{
            var leftBtn=UIButton(frame:CGRectMake(2, 130, 150, 28))
            leftBtn.addSubview(previewImgView)
            leftBtn.addSubview(previewLabel)
            self.addSubview(leftBtn)
            
            var middleLine=UIView(frame:CGRectMake(150, 135, 1, 20))
            middleLine.backgroundColor=UIColor.grayColor()
            middleLine.alpha=0.3
            self.addSubview(middleLine)
            
            var rightBtn=UIButton(frame:CGRectMake(152, 130, 150, 28))
            rightBtn.addSubview(commentImgView)
            rightBtn.addSubview(commentLabel)
            self.addSubview(rightBtn)
        }
        else{
            var leftBtn=UIButton(frame:CGRectMake(2, 130, 300, 28))
            leftBtn.addSubview(previewImgView)
            leftBtn.addSubview(previewLabel)
            previewImgView.setX(130)
            previewLabel.setX(150)
            leftBtn.addTarget(self,action:"preview:",forControlEvents:.TouchUpInside)
            self.addSubview(leftBtn)
        }
    }
    
    func otherImage(sender: UIButton!){
        // 跳转到详情内页
        var otherCon = OtherController()
        otherCon.uid = (data.objectForKey("uid") as String).toInt()!
        self.getController.presentModalViewController(otherCon, animated:true)
    }
    
    func preview(sender: UIButton!){
        // 跳转到详情内页
        var detailsCon = DetailsController()
        detailsCon.id = (data.objectForKey("id") as String).toInt()!
        self.getController.presentModalViewController(detailsCon, animated:true)
    }
}