//
//  MyDataController.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    
    var dataArray = NSMutableArray() //用户数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginViewDraw(_controller: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    
    
    func loginBtn(sender: UIButton!){
        var userName=self.dataArray[sender.tag].objectForKey("uname") as String
        //        BHAlertView().Success(self.bodyController, title: "任务完成", subTitle: "是否已完成该任务？", alertType: "alertFinish")
        BHAlertView().Login(self, title: "登录", subTitle: "确定以\(userName)的身份登录吗？", alertType: "alertLogin", cellData: self.dataArray[sender.tag] as NSDictionary )
    }
}