//
//  DetailsController.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/11/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class DetailsController: UIViewController {
    var commentField:UITextField? //评论输入框
    
    var rowIndex: Int = 0
    var id: Int = 0
    var data: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func loadData(id:Int){
        var url = "http://mm.renren.com/task-get?id=" + String(id)
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            if data as NSObject == NSNull(){
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            
            self.data = data["data"] as NSDictionary!
            DetailViewDraw(_controller: self)
            var gestureTap=UITapGestureRecognizer(target: self, action: Selector("viewTapped"))
            gestureTap.cancelsTouchesInView = false;
            self.view.addGestureRecognizer(gestureTap)
        })
    }
    
    func viewTapped() {
        self.commentField!.resignFirstResponder()
    }
    
    func cancelKeyboard() {
        viewTapped()
    }
    
    func otherImage(sender: UIButton!){
//        println(123)
        // 跳转到详情内页
        var otherCon = OtherController()
        otherCon.uid = (self.data!.objectForKey("uid") as String).toInt()!
        self.presentModalViewController(otherCon, animated:true)
    }
    
    func detailDoIt(sender: UIButton!){
        BHAlertView().doIt(self, title: "任务领取", subTitle: "是否确定领取该任务，\n并在2014-05-19 17:00前完成？")
    }
    
    func goBackAction(sender: UIButton!) {
//        self.navigationController.popViewControllerAnimated(true)
        self.dismissModalViewControllerAnimated(true)
    }
}