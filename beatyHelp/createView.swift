//
//  detailView.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/13/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit
class CreateViewDraw{
    var scrollView:UIScrollView! //创建滚动并设置尺寸
    var typeBtnArray:UIButton[] = []
    var timeField:UITextField!
    var moneyField:UITextField!
    var timeSelect:UIDatePicker!
    
    init(_controller: CreateController){
        GetUIBaseView(_controller: _controller)
        GetHeadBar(_controller: _controller, _title: "发布任务")
        setScrollView(_controller)
        var typeBox = GetCreateView(_controller: _controller,_scrollView: scrollView)
        typeBtnArray=typeBox.typeBtnArray
        timeField=typeBox.timeField
        moneyField=typeBox.moneyField
        timeSelect=typeBox.timeSelect
    }
    
    func setScrollView(_controller:UIViewController){
        scrollView = UIScrollView(frame:CGRectMake(0, 60, 320, UIScreen.mainScreen().applicationFrame.height-60))
        // 设置可滚动的区域
        scrollView.contentSize = CGSizeMake(320, UIScreen.mainScreen().applicationFrame.height-60)
        _controller.view.addSubview(scrollView)
    }
}

class GetCreateView{
    var bodyController:UIViewController!
    var bodyView:UIScrollView!
    var typeCon:UIView!
    var typeBtnArray:UIButton[] = []
    var timeField:UITextField!
    var moneyField:UITextField!
    var timeSelect:UIDatePicker!
    init(_controller:UIViewController,_scrollView: UIScrollView){
        bodyController=_controller
        bodyView=_scrollView
        setTypeCon()
        setInfoCon()
    }
    
    func setTypeCon(){
        typeCon=UIView(frame:CGRectMake(10, 15, 300,93))
        var topLayer = typeCon.layer
        topLayer.backgroundColor = getColorFromDictionary("greyf3").CGColor
        topLayer.cornerRadius=3
        topLayer.borderWidth=1
        topLayer.borderColor=UIColor.whiteColor().CGColor
        topLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).CGColor
        topLayer.shadowOffset = CGSizeMake(0, 1)
        bodyView.addSubview(typeCon)
        setTypeBtnArray()
        setTimeSelect()
        setToolbar()
    }
    
    func setTypeBtnArray(){
        var btnX = [11, 108, 206]
        for i in 0..3{
            var typeBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            typeBtn.frame = CGRectMake(CGFloat(btnX[i]), 17, 82, 24)
            typeBtn.setImage(UIImage(named:"typeBtn\(i+1)"), forState: UIControlState.Normal)
            typeBtn.setImage(UIImage(named:"typeBtn\(i+1)x"), forState: UIControlState.Highlighted)
            typeBtn.setImage(UIImage(named:"typeBtn\(i+1)x"), forState: UIControlState.Selected)
            typeBtn.addTarget(bodyController,action:Selector("typeBtnAction:"),forControlEvents:.TouchUpInside);
            typeBtnArray.insert(typeBtn, atIndex: i)
            typeCon.addSubview(typeBtn)
        }
        typeBtnArray[0].selected=true
    }
    
    func setTimeSelect(){
        timeField=UITextField(frame:CGRectMake(11, 52, 132,27))
        timeField.backgroundColor=UIColor.whiteColor()
        timeField.placeholder="有效期：2014-01-05"
        timeField.font=UIFont(name:"Arial",size:12)
        var timeLayer = timeField.layer
        timeLayer.cornerRadius=3;
        timeLayer.borderWidth = 1
        timeLayer.borderColor = UIColor(red: 190, green: 195, blue: 199, alpha: 1).CGColor
        typeCon.addSubview(timeField)
        
        
        
        
        moneyField=getMoneyField(_UIView:typeCon)
        
        timeSelect=UIDatePicker(frame:CGRectMake(0, 0, 0,0))
        timeField.inputView=timeSelect
    }
    
    func setToolbar(){
        var toolbarView=UIToolbar(frame:CGRectMake(0, 0, 320,20))
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
        timeField.inputAccessoryView=toolbarView
        moneyField.inputAccessoryView=toolbarView
        
    }
    
    func setInfoCon(){
        //第一层外框
        var infoCon=UIView(frame:CGRectMake(10, 125, 300,180))
        var conLayer = infoCon.layer
        conLayer.cornerRadius=3
        bodyView.addSubview(infoCon)
        infoCon.clipsToBounds=true
        
        //底部
        var infoBg=UIView(frame:CGRectMake(0, 0, 300,180))
        var infoLayer = infoBg.layer
        infoLayer.backgroundColor = getColorFromDictionary("greyf3").CGColor
        infoLayer.cornerRadius=3
        infoLayer.borderWidth=1
        infoLayer.borderColor=UIColor.whiteColor().CGColor
        infoLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).CGColor
        infoLayer.shadowOffset = CGSizeMake(0, 1)
        infoCon.addSubview(infoBg)
        
        //topbar
        var topBar=UIView(frame:CGRectMake(0, 0, 300,30))
        topBar.backgroundColor=getColorFromDictionary("red")
        var topLayer = topBar.layer
        topLayer.borderWidth=1
        topLayer.borderColor=getColorFromDictionary("red").CGColor
        infoCon.addSubview(topBar)
        
        
        var conIcon = UIImageView(frame:CGRectMake(120,8,15,15))
        var conLabel=UILabel(frame:CGRectMake(140, 8, 50, 15))
        conIcon.image = UIImage(named:"detailsIcon")
        conLabel.text="任务详情"
        conLabel.textColor=UIColor.whiteColor()
        conLabel.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        conLabel.shadowOffset = CGSizeMake(0, 0.5)
        conLabel.font=UIFont(name:"Arial",size:12)
        conLabel.textAlignment = NSTextAlignment.Center
        topBar.addSubview(conIcon)
        topBar.addSubview(conLabel)
        
        //textLabel
        var infoLabel=UILabel(frame:CGRectMake(15, 35, 270,50))
        infoLabel.text="任务详情任务详情任务详情任务详情任务详情任务详情任务详情"
        infoLabel.textColor=UIColor.blackColor()
        infoLabel.textColor=UIColor.grayColor()
        infoLabel.font=UIFont(name:"Arial",size:12)
        infoCon.addSubview(infoLabel)
        
        //textBg
//        var textBg=UIView(frame:CGRectMake(15, 45, 270,100))
//        textBg.backgroundColor=UIColor.whiteColor()
//        var textBgLayer = textBg.layer
//        textBgLayer.cornerRadius=3
//        textBgLayer.borderWidth=1
//        textBgLayer.borderColor=UIColor.whiteColor().CGColor
//        infoCon.addSubview(textBg)
        
    }
    
}

class getMoneyField:UITextField , UITextFieldDelegate{
    init(_UIView:UIView){
        super.init(frame:CGRectMake(157, 52, 132,27))
        self.backgroundColor=UIColor.whiteColor()
        self.placeholder="悬赏：100"
        self.font=UIFont(name:"Arial",size:12)
        self.returnKeyType=UIReturnKeyType.Done
        self.delegate = self
        var moneyLayer = self.layer
        moneyLayer.cornerRadius=3;
        moneyLayer.borderWidth = 1
        moneyLayer.borderColor = UIColor(red: 190, green: 195, blue: 199, alpha: 1).CGColor
        self.keyboardType=UIKeyboardType.NumberPad
        self.clearButtonMode=UITextFieldViewMode.WhileEditing
        _UIView.addSubview(self)
    }
    
    
    func textFieldDidEndEditing(textField: UITextField!){
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        
        textField.resignFirstResponder()
                return true
    }
}