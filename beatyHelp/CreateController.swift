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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var createView=CreateViewDraw(_controller: self)
        typeBtnArray=createView.typeBtnArray
        timeField=createView.timeField
        moneyField=createView.moneyField
        timeSelect=createView.timeSelect
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
    }
    
    func cancelKeyboard() {
        self.timeField!.resignFirstResponder()
        self.moneyField!.resignFirstResponder()
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
        self.timeField!.resignFirstResponder()
        self.moneyField!.resignFirstResponder()
    }
    
}