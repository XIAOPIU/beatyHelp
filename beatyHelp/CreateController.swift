//
//  DetailsController.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/13/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class CreateController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    var rowIndex: Int = 0
    var typeBtnArray:UIButton[] = []
    var timeField:UITextField?
    var moneyField:UITextField?
    var timeSelect:UIDatePicker?
    var infoInput:getInputArea?
    var whisperInput:getInputArea?
    var telInput:getInputArea?
    var chooseType:Int = 1
    var scrollView:UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var createView=CreateViewDraw(_controller: self)
        scrollView=createView.scrollView
        typeBtnArray=createView.typeBtnArray
        timeField=createView.timeField
        moneyField=createView.moneyField
        timeSelect=createView.timeSelect
        infoInput=createView.infoInput
        whisperInput=createView.whisperInput
        telInput=createView.telInput
        var gestureTap=UITapGestureRecognizer(target: self, action: Selector("viewTapped"))
        gestureTap.cancelsTouchesInView = false;
        self.view.addGestureRecognizer(gestureTap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    //textfiled代理协议方法
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField!){
        var viewFrame=self.scrollView!.frame
        viewFrame.size.height=viewFrame.size.height-250
        self.scrollView!.frame=viewFrame
        var textFieldRect=textField.superview.frame
        self.scrollView!.scrollRectToVisible(textFieldRect, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField!){
        textField.resignFirstResponder()
        var viewFrame=self.scrollView!.frame
        viewFrame.size.height=viewFrame.size.height+250
        self.scrollView!.frame=viewFrame
    }
    
    //textView代理协议方法
//    func textViewShouldReturn(textField: UITextField!) -> Bool{
//        textField.resignFirstResponder()
//        return true
//    }
    
    func textViewDidBeginEditing(textView: UITextView!){
        var viewFrame=self.scrollView!.frame
        viewFrame.size.height=viewFrame.size.height-250
        self.scrollView!.frame=viewFrame
        var textFieldRect=textView.superview.superview.frame
        self.scrollView!.scrollRectToVisible(textFieldRect, animated: true)
    }
    
    func textViewDidEndEditing(textView: UITextView!){
        textView.resignFirstResponder()
        var viewFrame=self.scrollView!.frame
        viewFrame.size.height=viewFrame.size.height+250
        self.scrollView!.frame=viewFrame
    }
    
    func goBackAction(sender: UIButton!) {
        //        self.navigationController.popViewControllerAnimated(true)
        self.dismissModalViewControllerAnimated(true)
    }
    
    func typeBtnAction(sender: UIButton!) {
        for i in 0..3{
            typeBtnArray[i].selected=false;
        }
        sender.selected=true;
        self.chooseType=Int(sender.tag)+1
    }
    
    func pubBtnAction(sender: UIButton!) {
        var postStr:NSString!
        var coin=self.moneyField!.text
        var info=self.infoInput!.inputArea.text
        var whisper=self.whisperInput!.inputArea.text
        var duedate=self.timeField!.text
        var mobile=self.telInput!.inputField.text
        postStr="school=湖南大学&tasktype=\(self.chooseType)&coin=\(coin)&intro=\(info)&whisper=\(whisper)&contact=\(mobile)&userid=11&status=1&duedate=\(duedate)"
//        postStr="id=21&school=清华大学&tasktype=3&contact=18594562365&userid=11&status=1&duedate=2014-10-10"
        var getDate=PostRequest(_controller:self,_url:"http://mm.nextsystem.pw/task-save",_postStr:postStr,_type:"pub")
        println(postStr)
    }
    
    
    func viewTapped() {
        self.timeField!.resignFirstResponder()
        self.moneyField!.resignFirstResponder()
        self.infoInput!.inputArea.resignFirstResponder()
        self.whisperInput!.inputArea.resignFirstResponder()
        self.telInput!.inputField.resignFirstResponder()
    }

    
    func cancelKeyboard() {
        viewTapped()
    }
    
    func finishKeyboard() {
        //获取选择时间
        if self.timeField!.editing{
            var pickerDate=self.timeSelect!.date
            var formatter=NSDateFormatter()
            formatter.dateFormat="YYYY-MM-dd HH:mm"
            var inputDate=formatter.stringFromDate(pickerDate)
            self.timeField!.text=inputDate
        }
        viewTapped()
    }
    
}
