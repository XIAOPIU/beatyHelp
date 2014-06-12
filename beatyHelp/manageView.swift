//
//  manageView.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

<<<<<<< HEAD
func manageViewDraw(controller:UIViewController){
    // 为controller添加baseView
    getUIBaseView(controller)
    getFootBar(controller,2)
    getTopTab(controller)
}

func getTopTab(controller:UIViewController){
    var topTab:UIView! // 创建顶部Tab
    var leftTab:UIButton! // 发布的任务
    var rightTab:UIButton! //领取的任务
    var separator:UIImageView //tab中间的分隔线
    var bottomLine:UIImageView //底部分隔线
    var pageIndex = 1
    
    
    
    
    //创建顶部Tab框体并设置尺寸
    topTab = {
        () -> UIView in
        topTab = UIView(frame:CGRectMake(10, 20, 300, 42))
        var layer = topTab.layer
        controller.view.addSubview(topTab)
        return topTab
        }()
    
    //分隔线
    separator=UIImageView(frame:CGRectMake(149,13,1,18))
    separator.image = UIImage(named:"separator")
    topTab.addSubview(separator)
    
    bottomLine=UIImageView(frame:CGRectMake(0,39,300,2.5))
    bottomLine.image = UIImage(named:"bottomLine")
    topTab.addSubview(bottomLine)
    
    //创建顶部发布的任务Tab并设置尺寸
    leftTab = {
        () -> UIButton in
        leftTab = UIButton(frame:CGRectMake(15, 11, 120, 20))
        var leftTabIcon = UIImageView(frame:CGRectMake(0,0,18,17))
        leftTabIcon.image = UIImage(named:"leftTabIcon")
        leftTab.addSubview(leftTabIcon)
        
        var leftTabLabel=UILabel(frame:CGRectMake(20, 0, 120, 20))
        leftTabLabel.text="发布的任务(21)"
        leftTabLabel.font=UIFont(name:"Arial",size:13)
        leftTabLabel.textColor=UIColor.whiteColor()
        leftTab.addSubview(leftTabLabel)
        topTab.addSubview(leftTab)
        leftTab.addTarget(controller,action:"leftTabAction:",forControlEvents:.TouchUpInside);
        return leftTab
        }()
    
    //创建顶部领取的任务Tab并设置尺寸
    rightTab = {
        () -> UIButton in
        rightTab = UIButton(frame:CGRectMake(165, 11, 120, 20))
        var rightTabIcon = UIImageView(frame:CGRectMake(0,0,18,17))
        rightTabIcon.image = UIImage(named:"rightTabIcon")
        rightTab.addSubview(rightTabIcon)
        
        var rightTabLabel=UILabel(frame:CGRectMake(20, 0, 120, 20))
        rightTabLabel.text="领取的任务(21)"
        rightTabLabel.font=UIFont(name:"Arial",size:13)
        rightTabLabel.textColor=UIColor.whiteColor()
        rightTab.addSubview(rightTabLabel)
        topTab.addSubview(rightTab)
        rightTab.addTarget(controller,action:"rightTabAction:",forControlEvents:.TouchUpInside);
        
        return rightTab
        }()

    
}

func getPubTableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!,index:Int) -> UITableViewCell!{
    var arrayDic = getDictionary("list") as NSArray
    var rowNo = indexPath.row
    var identifier = arrayDic[rowNo%3].objectForKey("identifier") as String
    var dateText = arrayDic[rowNo%3].objectForKey("time") as String
    var userImage = arrayDic[rowNo%3].objectForKey("userImage") as String
    var dateLabel = UILabel(frame:CGRectMake(198, 14, 160, 20))
    var imageName:String
    if index==1{
        imageName = arrayDic[rowNo%3].objectForKey("imageName") as String
    }
    else{
        imageName = arrayDic[(rowNo+1)%3].objectForKey("imageName") as String
    }
    
    var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath:indexPath) as UITableViewCell
    cell.backgroundColor = UIColor.clearColor()
    
    var img = UIImage(named:imageName).stretchableImageWithLeftCapWidth(0, topCapHeight:70)
    var imgView = UIImageView(image:img)
    imgView.frame = CGRectMake(0, 10, 306 , 125)
    cell.addSubview(imgView)
    
    dateLabel.text = dateText
    dateLabel.font = UIFont(name:"Arial",size:10)
    dateLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    cell.addSubview(dateLabel)
    // 添加圆形头像
    creatRoundImage(cell,CGRectMake(3, 9, 64, 64),userImage,1.5);
    return cell
}

=======
class ManageViewDraw{
    init(_controller: UIViewController){
        GetUIBaseView(_controller: _controller)
        GetFootBar(_controller: _controller, _index: 2)
    }
}
>>>>>>> FETCH_HEAD
