//
//  manageView.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class ManageViewDraw{
    var leftTab:UIButton! // 发布的任务
    var rightTab:UIButton! //领取的任务
    
    init(_controller: UIViewController){
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
        tabIcon.image = UIImage(named:"leftTabIcon")
        tabLabel.text="发布的任务(21)"
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
    var timeLabel:UILabel!
    var imgView:UIImageView!
    
    init(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!,tableIndex:Int){
        var arrayDic = getDictionary("list") as NSArray
        var rowNo = indexPath.row
        var identifier = arrayDic[rowNo%3].objectForKey("identifier") as String
        var imageName = arrayDic[rowNo%3].objectForKey("imageName") as String
        var dateText = arrayDic[rowNo%3].objectForKey("time") as String
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
        imgView.frame = CGRectMake(0, 10, 306 , 125)
        cell.addSubview(imgView)
        
        timeLabel = UILabel(frame:CGRectMake(198, 14, 160, 20))
        timeLabel.text = dateText
        timeLabel.font = UIFont(name:"Arial",size:10)
        timeLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        cell.addSubview(timeLabel)
        // 添加圆形头像
        creatRoundImage(cell,CGRectMake(3, 9, 64, 64),userImage,1.5);
    }
}