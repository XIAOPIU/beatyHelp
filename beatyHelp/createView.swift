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
    var infoInput:getInputArea!
    var whisperInput:getInputArea!
    var telInput:getInputArea!
    
    init(_controller: CreateController){
        GetUIBaseView(_controller: _controller)
        GetHeadBar(_controller: _controller, _title: "发布任务")
        setScrollView(_controller)
        var typeBox = GetCreateView(_controller: _controller,_scrollView: scrollView)
        typeBtnArray=typeBox.typeBtnArray
        timeField=typeBox.timeField
        moneyField=typeBox.moneyField
        timeSelect=typeBox.timeSelect
        infoInput=typeBox.infoInput
        whisperInput=typeBox.whisperInput
        telInput=typeBox.telInput
    }
    
    func setScrollView(_controller:UIViewController){
        scrollView = UIScrollView(frame:CGRectMake(0, 60, 320, UIScreen.mainScreen().applicationFrame.height-60))
        // 设置可滚动的区域
        scrollView.contentSize = CGSizeMake(320, 700)
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
    var infoInput:getInputArea!
    var whisperInput:getInputArea!
    var telInput:getInputArea!
    init(_controller:UIViewController,_scrollView: UIScrollView){
        bodyController=_controller
        bodyView=_scrollView
        infoInput=getInputArea(_scrollView: bodyView,type:0)
        whisperInput=getInputArea(_scrollView: bodyView,type:1)
        telInput=getInputArea(_scrollView: bodyView,type:2)
        whisperInput.setY(342)
        telInput.setY(563)
        setPubBtn()
        setTypeCon()
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
            typeBtn.tag=i
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
        timeField.inputAccessoryView=toolbarView
        moneyField.inputAccessoryView=toolbarView
        infoInput.inputArea.inputAccessoryView=toolbarView
        whisperInput.inputArea.inputAccessoryView=toolbarView
        
    }
    
    func setPubBtn(){
        var img = UIImage(named: "blueBtn")
        img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
        img.accessibilityFrame = CGRectMake(0, 0, 304, 36)
        var button = GetlargeBtn(_frame : CGRectMake(7, 650, 306, 36), _img : img, _title : "发布任务").button
        button.addTarget(bodyController,action:Selector("pubBtnAction:"),forControlEvents:.TouchUpInside);
        bodyView.addSubview(button)
    }
    
}

class getMoneyField:UITextField , UITextFieldDelegate{
    init(_UIView:UIView){
        super.init(frame:CGRectMake(157, 52, 132,27))
        self.backgroundColor=UIColor.whiteColor()
        self.placeholder="悬赏：100"
        self.font=UIFont(name:"Arial",size:12)
        self.delegate = self
        var moneyLayer = self.layer
        moneyLayer.cornerRadius=3;
        moneyLayer.borderWidth = 1
        moneyLayer.borderColor = UIColor(red: 190, green: 195, blue: 199, alpha: 1).CGColor
        self.clearButtonMode=UITextFieldViewMode.WhileEditing
        self.returnKeyType=UIReturnKeyType.Done
//        self.keyboardAppearance = .Dark;
        self.keyboardType=UIKeyboardType.Default
//        var timeSelect=UIView(frame:CGRectMake(0, 0, 320,100))
//        timeSelect.backgroundColor=UIColor.blackColor()
//        var timeSelect=UIDatePicker(frame:CGRectMake(0, 0, 0,0))
//        self.inputView=timeSelect
        _UIView.addSubview(self)
    }
    
    
    func textFieldDidEndEditing(textField: UITextField!){
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        
        textField.resignFirstResponder()
                return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField!){
    }
}

class getInputArea:UIView{
    var inputArea:UITextView!
    var inputType:Int!
    var desInfo:String[]=[]
    init(_scrollView:UIScrollView,type:Int){
        inputType=type
        //设置第一层外框
        super.init(frame:CGRectMake(10, 125, 300,200))
        var conLayer = self.layer
        conLayer.cornerRadius=3
        self.clipsToBounds=true
        
        setAreaBg()
        if inputType==2{
            desInfo=["联系信息", "mobileIcon2"]
            self.setHeight(70)
            setNumberArea()
        }
        else if inputType==1{
            desInfo=["悄悄话", "whisperIcon", "请包括地点、时间等信息，还可以有诸如请客、支付报酬等悬赏哦！"]
            setInputArea()
        }
        else{
            desInfo=["任务详情", "detailsIcon", "请包括地点、时间等信息，还可以有诸如请客、支付报酬等悬赏哦！"]
            setInputArea()
        }
        setTitleBar()
        _scrollView.addSubview(self)
    }
    
    //整个区域的背景
    func setAreaBg(){
        var areaBg=UIView(frame:CGRectMake(0, 0, 300,200))
        if inputType==2{
            areaBg.setHeight(70)
        }
        var areaBgLayer = areaBg.layer
        areaBgLayer.backgroundColor = getColorFromDictionary("greyf3").CGColor
        areaBgLayer.cornerRadius=3
        areaBgLayer.borderWidth=1
        areaBgLayer.borderColor=UIColor.whiteColor().CGColor
        areaBgLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).CGColor
        areaBgLayer.shadowOffset = CGSizeMake(0, 1)
        self.addSubview(areaBg)
    }
    
    //顶部titleBar
    func setTitleBar(){
        var titleBar=UIView(frame:CGRectMake(0, 0, 300,30))
        titleBar.backgroundColor=getColorFromDictionary("red")
        var titleBarLayer = titleBar.layer
        titleBarLayer.borderWidth=1
        titleBarLayer.borderColor=getColorFromDictionary("red").CGColor
        self.addSubview(titleBar)
        
        //绘制title的图标和文字
        var titleIcon = UIImageView(frame:CGRectMake(120,8,15,15))
        titleIcon.image = UIImage(named:desInfo[1])
        titleBar.addSubview(titleIcon)
        
        var titleLabel=UILabel(frame:CGRectMake(140, 8, 50, 15))
        titleLabel.text=desInfo[0]
        titleLabel.textColor=UIColor.whiteColor()
        titleLabel.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        titleLabel.shadowOffset = CGSizeMake(0, 0.5)
        titleLabel.font=UIFont(name:"Arial",size:12)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleBar.addSubview(titleLabel)
        
    }
    
    //文本区域
    func setInputArea(){
        //描述信息
        var tipsLabel=UILabel(frame:CGRectMake(15, 38, 270,30))
        tipsLabel.text=desInfo[2]
        tipsLabel.textColor=UIColor.grayColor()
        tipsLabel.font=UIFont(name:"Arial",size:11)
        tipsLabel.lineBreakMode = .ByWordWrapping
        tipsLabel.numberOfLines = 0
        self.addSubview(tipsLabel)
        
        //文本框背景
        var inputBg=UIView(frame:CGRectMake(15, 72, 270,115))
        inputBg.backgroundColor=UIColor.whiteColor()
        var inputBgLayer = inputBg.layer
        inputBgLayer.cornerRadius=3
        inputBgLayer.borderWidth=1
        inputBgLayer.borderColor=UIColor.whiteColor().CGColor
        self.addSubview(inputBg)
        
        //文本框
        inputArea=UITextView(frame:CGRectMake(0, 0, 270,95))
        inputArea.backgroundColor=UIColor.clearColor()
        inputBg.addSubview(inputArea)
        
        //文本计数
        var inputAreaNum=UILabel(frame:CGRectMake(215, 95, 50,20))
        inputAreaNum.text="0/140"
        inputAreaNum.textColor=UIColor.grayColor()
        inputAreaNum.font=UIFont(name:"Arial",size:11)
        inputAreaNum.textAlignment=NSTextAlignment.Right
        inputBg.addSubview(inputAreaNum)
        
    }
    
    //电话号码
    func setNumberArea(){
        //描述信息
        var tipsLabel=UILabel(frame:CGRectMake(15, 35, 270,30))
        tipsLabel.text="18612270100"
        tipsLabel.textAlignment=NSTextAlignment.Center
        tipsLabel.textColor=UIColor.blackColor()
        tipsLabel.font=UIFont(name:"Arial",size:15)
        self.addSubview(tipsLabel)
    }
    
}

