//
//  detailView.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/11/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit
class DetailViewDraw{
    var scrollView:UIScrollView! //创建滚动并设置尺寸
    
    init(_controller:UIViewController){
        GetUIBaseView(_controller: _controller)
        GetHeadBar(_controller: _controller, _title: "任务详情")
        setScrollView(_controller)
        var detailTop = GetDetailTop(_scrollView: scrollView)
    }
    
    func setScrollView(_controller:UIViewController){
        scrollView = UIScrollView(frame:CGRectMake(0, 60, 320, UIScreen.mainScreen().applicationFrame.height-60))
        // 设置可滚动的区域
        scrollView.contentSize = CGSizeMake(320, UIScreen.mainScreen().applicationFrame.height)
        _controller.view.addSubview(scrollView)
    }
}

class GetDetailTop{
    var topBg: UIImageView!
    var timeLabel: UILabel!
    var userImage: UIImageView!
    
    init(_scrollView: UIScrollView){
        setTopBg(_scrollView)
        setTimeLabel()
        setUserImage()
    }
    
    func setTopBg(_scrollView: UIScrollView){
        var img = UIImage(named: "detailsTopBgRed").stretchableImageWithLeftCapWidth(0, topCapHeight:95)
        topBg = UIImageView(image: img)
        topBg.frame = CGRectMake(7, 5, 306 , 145)
        _scrollView.addSubview(topBg)
    }
    
    func setTimeLabel(){
        timeLabel = UILabel(frame:CGRectMake(198, 7, 160, 20))
        timeLabel.text = "至 2014-05-19  17:00"
        timeLabel.font = UIFont(name:"Arial",size:10)
        timeLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        topBg.addSubview(timeLabel)
    }
    
    func setUserImage(){
        userImage = creatRoundImage(topBg,CGRectMake(3, 2.5, 64, 64),"userList01.jpg",1.5);
    }
}