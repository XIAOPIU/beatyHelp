//
//  DetailsController.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/13/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class CreateController: UIViewController{
    var rowIndex: Int = 0
    var typeBtnArray:UIButton[] = []
    var timeField:UITextField?
    var moneyField:UITextField?
    var timeSelect:UIDatePicker?
    var infoInput:getInputArea?
    var whisperInput:getInputArea?
    var telInput:getInputArea?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var createView=CreateViewDraw(_controller: self)
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
        
        var postStr:NSString!
        postStr="id=16&tasktype=3&coin=100&intro=啊啊，有木有人帮我去快递呀，放假在家取不到呀！天马公寓出门左拐顺丰&whisper=哈哈哈&userid=11"
        var getDate=PostRequest(_controller:self,_url:"http://mm.renren.com/task-update",_postStr:postStr)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
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
    }
    
    func viewTapped() {
        self.timeField!.resignFirstResponder()
        self.moneyField!.resignFirstResponder()
        self.infoInput!.inputArea.resignFirstResponder()
        self.whisperInput!.inputArea.resignFirstResponder()
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