//
//  MyDataController.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class MyDataController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        MyDataViewDraw(_controller: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func footBtn1Action(sender: UIButton!) {
        var ViewCon = ViewController()
//        ViewCon.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        self.presentModalViewController(ViewCon, animated:false)
    }
    
    func footBtn2Action(sender: UIButton!) {
        var manageCon = ManageController()
//        manageCon.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        self.presentModalViewController(manageCon, animated:false)
    }
    
    func signOut(sender: UIButton!){
        BHAlertView().signOut(self, title: "注销当前帐号", subTitle: "是否确定退出该帐号？",alertType: "signOut")
    }
}