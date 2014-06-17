//
//  baseView.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/6/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

/**
*  为controller添加baseView
*
*  @param view 需要添加的UIView
*/
class GetUIBaseView{
    init(_controller:UIViewController){
        // 为背景平铺背景图
        _controller.view.backgroundColor = UIColor(patternImage: UIImage(named:"bgMini"))
    }
}

class GetFootBar{
    var footBg:UIImageView! // 底部框体包括背景图
    var footBtnArray:UIButton[] = []
    
    init(_controller:UIViewController, _index:Int){
        getFootBg(_controller)
        getFootBtnArray(_controller, index: _index)
    }
    
    func getFootBg(controller:UIViewController){
        // 创建框体并设置尺寸
        footBg = UIImageView(frame:CGRectMake(0,UIScreen.mainScreen().applicationFrame.height+20-39,320,39))
        //根据图片名，确定图片引用
        footBg.image = UIImage(named:"footLine")
        // 将圆图添加到UIView上
        controller.view.addSubview(footBg)
    }
    
    func getFootBtnArray(controller:UIViewController, index:Int){
        var btnWidth = [111, 104, 103]
        var btnX = [0, 112, 217]
        
        for i in 0..3{
            var footBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            footBtn.frame = CGRectMake(CGFloat(btnX[i]), UIScreen.mainScreen().applicationFrame.height+20-39, CGFloat(btnWidth[i]), 39)
            footBtn.setImage(UIImage(named:(index==i+1 ? "footBtn0\(i+1)" : "footBtn0\(i+1)x" )), forState: UIControlState.Normal)
            if index != i+1 {
                footBtn.addTarget(controller,action:Selector("footBtn\(i+1)Action:"),forControlEvents:.TouchUpInside);
            }
            footBtnArray.insert(footBtn, atIndex: i)
            controller.view.addSubview(footBtn)
        }
    }
}

class GetHeadBar{
    var headBg:UIImageView! // 顶部框体包括背景图
    var titleLabel:UILabel! // 顶部标题
    var backBtn:UIButton! // 顶部返回按钮
    
    init(_controller:UIViewController,_title:String){
        setHeadBg(_controller)
        setTitleLabel(_title)
        setBackBtn(_controller)
    }
    
    func setHeadBg(controller:UIViewController){
        // 创建框体并设置尺寸
        headBg = UIImageView(frame:CGRectMake(0,20,320,40))
        //根据图片名，确定图片引用以及拉伸
        headBg.image = UIImage(named:"headBg").stretchableImageWithLeftCapWidth(4, topCapHeight:0)
        // 将圆图添加到UIView上
        controller.view.addSubview(headBg)
    }
    
    func setTitleLabel(title:String){
        titleLabel = UILabel(frame:CGRectMake(60,11,200,16))
        titleLabel.text = title
        titleLabel.font = UIFont(name:"Arial",size:16)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.75)
        titleLabel.shadowOffset = CGSizeMake(0, 0.5)
        titleLabel.textAlignment = NSTextAlignment.Center
        headBg.addSubview(titleLabel)
    }
    
    func setBackBtn(controller:UIViewController){
        backBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        backBtn.frame = CGRectMake(15, 31, 17, 17)
        backBtn.setImage(UIImage(named:"headBackBtn01"), forState: UIControlState.Normal)
        backBtn.addTarget(controller,action:"goBackAction:",forControlEvents:.TouchUpInside);
        controller.view.addSubview(backBtn)
    }
}


class GetlargeBtn{
    var button:UIButton!
    
    init(_frame : CGRect, _img : UIImage, _title : String){
        button = UIButton(frame:_frame)
        button.setBackgroundImage(_img, forState: UIControlState.Normal)
        button.setTitle(_title, forState: UIControlState.Normal)
        button.titleLabel.font = UIFont(name:"Arial",size:12)
    }
}
