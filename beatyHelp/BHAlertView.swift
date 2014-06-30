//
//  BHAlertView.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/17/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

// Pop Up Styles
enum BHAlertViewStyle: Int {
    case Success
    case Error
    case Notice
    case Warning
    case Info
    case DoIt
    case FinishIt
    case Login
    case Share
    case Comment
    case SignOut
}

// Allow alerts to be closed/renamed in a chainable manner
// Example: BHAlertView().showSuccess(self, title: "Test", subTitle: "Value").Close()
class BHAlertViewClose {
    let alertview: BHAlertView
    
    // Initialisation and Title/Subtitle/Close functions
    init(alertview: BHAlertView) { self.alertview = alertview }
    func setTitle(title: String) { self.alertview.labelView.text = title; }
    func setSubTitle(subTitle: String) { self.alertview.labelViewDescription.text = subTitle; }
    func Close() { self.alertview.doneButtonAction() }
}

// The Main Class
class BHAlertView : UIView {
    let kDefaultShadowOpacity: CGFloat = 0.7;
    let kCircleHeight: CGFloat = 56.0;
    let kCircleTopPosition: CGFloat = -12; // Should not be defined here. Make it dynamic
    let kCircleBackgroundTopPosition: CGFloat = -15; // Should not be defined here. Make it dynamic
    let kCircleHeightBackground: CGFloat = 62.0;
    let kCircleIconHeight: CGFloat = 30.0;
    let kWindowWidth: CGFloat = 240.0;
    let kWindowHeight: CGFloat = 228.0;
    
    // Font
    let kDefaultFont: NSString = "HelveticaNeue"
    
    // Members declaration
    var labelView: UILabel
    var labelViewDescription: UILabel
    var shadowView: UIView
    var contentView: UIView
    var circleView: UIView
    var circleViewBackground: UIView
    var circleIconImageView: UIImageView
    var doneButton: UIButton
    var rootViewController: UIViewController
    var durationTimer: NSTimer!
    var alertType = ""
    var userId = ""
    var cellData: NSDictionary!
    var conView: UIViewController!
    var tableCell:UITableViewCell!
    
    init () {
        // Content View
        self.contentView = UIView(frame: CGRectMake(0, kCircleHeight / 4, kWindowWidth, kWindowHeight))
        self.contentView.backgroundColor = UIColor(white: 1, alpha: 1);
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = true;
        self.contentView.layer.borderWidth = 0.5;
        
        // Circle View
        self.circleView = UIView(frame: CGRectMake(kWindowWidth / 2 - kCircleHeight / 2, kCircleTopPosition, kCircleHeight, kCircleHeight))
        self.circleView.layer.cornerRadius =  self.circleView.frame.size.height / 2;
        
        // Circle View Background
        
        self.circleViewBackground = UIView(frame: CGRectMake(kWindowWidth / 2 - kCircleHeightBackground / 2, kCircleBackgroundTopPosition, kCircleHeightBackground, kCircleHeightBackground))
        self.circleViewBackground.layer.cornerRadius =  self.circleViewBackground.frame.size.height / 2;
        self.circleViewBackground.backgroundColor = UIColor.whiteColor()
        
        // Circle View Image
        self.circleIconImageView = UIImageView(frame: CGRectMake(kCircleHeight / 2 - kCircleIconHeight / 2, kCircleHeight / 2 - kCircleIconHeight / 2, kCircleIconHeight, kCircleIconHeight))
        self.circleView.addSubview(self.circleIconImageView)
        
        // Title
        self.labelView = UILabel(frame: CGRectMake(12, kCircleHeight / 2 + 22, kWindowWidth - 24, 40))
        self.labelView.numberOfLines = 1
        self.labelView.textAlignment = NSTextAlignment.Center
        self.labelView.font = UIFont(name: kDefaultFont, size: 20)
        self.contentView.addSubview(self.labelView)
        
        // Subtitle
        self.labelViewDescription = UILabel(frame: CGRectMake(12, 84, kWindowWidth - 24, 80))
        self.labelViewDescription.numberOfLines = 3
        self.labelViewDescription.textAlignment = NSTextAlignment.Center
        self.labelViewDescription.font = UIFont(name: kDefaultFont, size: 14)
        self.contentView.addSubview(self.labelViewDescription)
        
        // Shadow View
        self.shadowView = UIView(frame: UIScreen.mainScreen().bounds)
        self.shadowView.backgroundColor = UIColor.blackColor()
//        self.shadowView.addTarget(self.getController,action:"otherImage:",forControlEvents:.TouchUpInside)
        
        // Done Button
        
        self.doneButton = UIButton(frame: CGRectMake(12, kWindowHeight - 48, kWindowWidth - 24, 36))
        self.doneButton.layer.cornerRadius = 3
        self.doneButton.layer.masksToBounds = true
        self.doneButton.titleLabel.font = UIFont(name: kDefaultFont, size: 14)
        self.contentView.addSubview(self.doneButton)
        
        // Root view controller
        self.rootViewController = UIViewController()
        
        // Superclass initiation
        super.init(frame: CGRectMake(((320 - kWindowWidth) / 2), 0 - kWindowHeight, kWindowWidth, kWindowHeight))
        
        // Show notice on screen
        self.addSubview(self.contentView)
        self.addSubview(self.circleViewBackground)
        self.addSubview(self.circleView)
        
        // Colours
        self.contentView.backgroundColor = UIColorFromRGB(0xf3f3f3)
        self.labelView.textColor = UIColorFromRGB(0x4D4D4D)
        self.labelViewDescription.textColor = UIColorFromRGB(0x4D4D4D)
        self.contentView.layer.borderColor = UIColorFromRGB(0xCCCCCC).CGColor
        
        // On complete.
        self.doneButton.addTarget(self, action: Selector("doneButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        var tapGesture = UITapGestureRecognizer(target:self, action: Selector("closeAlert"))
        self.shadowView.userInteractionEnabled = true
        tapGesture.numberOfTapsRequired = 1
        self.shadowView.addGestureRecognizer(tapGesture)
    }
    
    // showTitle(view, title, subTitle, style)
    func showTitle(view: UIViewController, title: String, subTitle: String, style: BHAlertViewStyle) -> BHAlertViewClose {
        return showTitle(view, title: title, subTitle: subTitle, duration: 2.0, completeText: nil, style: style)
    }
    
    // showSuccess(view, title, subTitle)
    func showSuccess(view: UIViewController, title: String, subTitle: String, alertType:String) -> BHAlertViewClose {
        self.alertType = alertType
        return showTitle(view, title: title, subTitle: subTitle, duration: nil, completeText: nil, style: BHAlertViewStyle.Success);
    }
    
    // showError(view, title, subTitle)
    func showError(view: UIViewController, title: String, subTitle: String) -> BHAlertViewClose {
        return showTitle(view, title: title, subTitle: subTitle, duration: 2.0, completeText: nil, style: BHAlertViewStyle.Error);
    }
    
    // showNotice(view, title, subTitle)
    func showNotice(view: UIViewController, title: String, subTitle: String) -> BHAlertViewClose {
        return showTitle(view, title: title, subTitle: subTitle, duration: 2.0, completeText: nil, style: BHAlertViewStyle.Notice);
    }
    
    // showWarning(view, title, subTitle)
    func showWarning(view: UIViewController, title: String, subTitle: String) -> BHAlertViewClose {
        return showTitle(view, title: title, subTitle: subTitle, duration: 2.0, completeText: nil, style: BHAlertViewStyle.Warning);
    }
    
    // showInfo(view, title, subTitle)
    func showInfo(view: UIViewController, title: String, subTitle: String) -> BHAlertViewClose {
        return showTitle(view, title: title, subTitle: subTitle, duration: 2.0, completeText: nil, style: BHAlertViewStyle.Info);
    }
    
    // doIt(view, title, subTitle)
    func doIt(view: UIViewController, title: String, subTitle: String, alertType:String, cellData:NSDictionary) -> BHAlertViewClose {
        self.conView = view
        self.alertType = alertType
        self.cellData = cellData
        return showTitle(view, title: title, subTitle: subTitle, duration: nil, completeText: nil, style: BHAlertViewStyle.DoIt);
    }
    
    // FinishIt(view, title, subTitle)
    func FinishIt(view: UIViewController, title: String, subTitle: String, alertType:String, cellData:NSDictionary,tableCell:UITableViewCell) -> BHAlertViewClose {
        self.conView = view
        self.alertType = alertType
        self.cellData = cellData
        self.tableCell=tableCell
        return showTitle(view, title: title, subTitle: subTitle, duration: nil, completeText: nil, style: BHAlertViewStyle.FinishIt);
    }
    
    // Login(view, title, subTitle)
    func Login(view: UIViewController, title: String, subTitle: String, alertType:String, cellData:NSDictionary) -> BHAlertViewClose {
        self.conView = view
        self.alertType = alertType
        self.cellData = cellData
        return showTitle(view, title: title, subTitle: subTitle, duration: nil, completeText: nil, style: BHAlertViewStyle.Login);
    }
    
    // comment(view, title, subTitle)
    func comment(view: UIViewController, title: String, subTitle: String, alertType:String, userId:String) -> BHAlertViewClose {
        self.conView = view
        self.alertType = alertType
        self.userId = userId
        return showTitle(view, title: title, subTitle: subTitle, duration: nil, completeText: nil, style: BHAlertViewStyle.Comment);
    }
    
    // comment(view, title, subTitle)
    func share(view: UIViewController, title: String, subTitle: String, alertType:String) -> BHAlertViewClose {
        self.alertType = alertType
        return showTitle(view, title: title, subTitle: subTitle, duration: nil, completeText: nil, style: BHAlertViewStyle.Share);
    }
    
    // comment(view, title, subTitle)
    func signOut(view: UIViewController, title: String, subTitle: String, alertType:String) -> BHAlertViewClose {
        self.alertType = alertType
        return showTitle(view, title: title, subTitle: subTitle, duration: nil, completeText: nil, style: BHAlertViewStyle.SignOut);
    }
    
    
    // showTitle(view, title, subTitle, duration, style)
    func showTitle(view:UIViewController, title: String, subTitle: String, duration: NSTimeInterval?, completeText: String?, style: BHAlertViewStyle) -> BHAlertViewClose {
        self.alpha = 0;
        self.rootViewController = view
        self.rootViewController.view.addSubview(self.shadowView)
        self.rootViewController.view.addSubview(self)
        
        // Complete text
        if(completeText != nil) {
            self.doneButton.setTitle(completeText, forState: UIControlState.Normal)
        }
        
        // Alert colour/icon
        var viewColor: UIColor = UIColor()
        var iconImageName: NSString = ""
        
        // Icon style
        switch(style) {
        case BHAlertViewStyle.Success:
            viewColor = UIColorFromRGB(0x22B573)
            self.doneButton.backgroundColor = viewColor
            self.circleIconImageView.image = UIImage(named: "notification-success")
            self.doneButton.setTitle("确定", forState: UIControlState.Normal)
            
        case BHAlertViewStyle.Error:
            viewColor = UIColorFromRGB(0xC1272D)
            self.doneButton.backgroundColor = viewColor
            self.circleIconImageView.image = UIImage(named: "notification-error")
            self.doneButton.setTitle("done", forState: UIControlState.Normal)
            
        case BHAlertViewStyle.Notice:
            viewColor = UIColorFromRGB(0x727375)
            self.doneButton.backgroundColor = viewColor
            self.circleIconImageView.image = UIImage(named: "notification-notice")
            self.doneButton.setTitle("done", forState: UIControlState.Normal)
            
        case BHAlertViewStyle.Warning:
            viewColor = UIColorFromRGB(0xFFD110)
            self.doneButton.backgroundColor = viewColor
            self.circleIconImageView.image = UIImage(named: "notification-warning")
            self.doneButton.setTitle("确定", forState: UIControlState.Normal)
            
        case BHAlertViewStyle.Info:
            viewColor = UIColorFromRGB(0x2866BF)
            self.doneButton.backgroundColor = viewColor
            self.circleIconImageView.image = UIImage(named: "notification-info")
            self.doneButton.setTitle("done", forState: UIControlState.Normal)
            
        case BHAlertViewStyle.DoIt:
            viewColor = UIColorFromRGB(0xec473a)
            var img = UIImage(named: "redBtn")
            img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
            img.accessibilityFrame = CGRectMake(0, 0, kWindowWidth - 24, 36)
            self.circleIconImageView.image = UIImage(named: "alertIcon03")
            self.doneButton.setTitle("确定领取", forState: UIControlState.Normal)
            self.doneButton.setBackgroundImage(img, forState: UIControlState.Normal)
            
        case BHAlertViewStyle.FinishIt:
            viewColor = UIColorFromRGB(0xec473a)
            var img = UIImage(named: "redBtn")
            img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
            img.accessibilityFrame = CGRectMake(0, 0, kWindowWidth - 24, 36)
            self.circleIconImageView.image = UIImage(named: "alertIcon03")
            self.doneButton.setTitle("确定完成", forState: UIControlState.Normal)
            self.doneButton.setBackgroundImage(img, forState: UIControlState.Normal)
            
        case BHAlertViewStyle.Login:
            viewColor = UIColorFromRGB(0xec473a)
            var img = UIImage(named: "redBtn")
            img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
            img.accessibilityFrame = CGRectMake(0, 0, kWindowWidth - 24, 36)
//            layer.backgroundColor=UIColor.blackColor()
            var url=self.cellData.objectForKey("avatar") as String
            self.circleIconImageView.frame.origin.x=0
            self.circleIconImageView.frame.origin.y=0
            creatRoundImage(self.circleIconImageView,CGRectMake(0, 0, 56, 56),UIImage(),1.5).setImage(url,placeHolder: UIImage(named: "userList01.jpg"));
//            self.circleIconImageView.image = UIImage(named: "alertIcon03")
            self.doneButton.setTitle("确定登录", forState: UIControlState.Normal)
            self.doneButton.setBackgroundImage(img, forState: UIControlState.Normal)
            
        case BHAlertViewStyle.Share:
            viewColor = UIColorFromRGB(0xec473a)
            var img = UIImage(named: "redBtn")
            img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
            img.accessibilityFrame = CGRectMake(0, 0, kWindowWidth - 24, 36)
            self.circleIconImageView.image = UIImage(named: "alertIcon02")
            self.doneButton.setTitle("确定分享", forState: UIControlState.Normal)
            self.doneButton.setBackgroundImage(img, forState: UIControlState.Normal)
            
        case BHAlertViewStyle.Comment:
            viewColor = UIColorFromRGB(0xec473a)
            var img = UIImage(named: "redBtn")
            img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
            img.accessibilityFrame = CGRectMake(0, 0, kWindowWidth - 24, 36)
            self.circleIconImageView.image = UIImage(named: "alertIcon01")
            self.doneButton.setTitle("前往评论", forState: UIControlState.Normal)
            self.doneButton.setBackgroundImage(img, forState: UIControlState.Normal)
            
        case BHAlertViewStyle.SignOut:
            viewColor = UIColorFromRGB(0xec473a)
            var img = UIImage(named: "redBtn")
            img = img.stretchableImageWithLeftCapWidth(8, topCapHeight:0)
            img.accessibilityFrame = CGRectMake(0, 0, kWindowWidth - 24, 36)
            self.circleIconImageView.image = UIImage(named: "alertIcon04")
            self.doneButton.setTitle("退 出", forState: UIControlState.Normal)
            self.doneButton.setBackgroundImage(img, forState: UIControlState.Normal)
            
        default:
            println("default")
        }
        
        // Title
        if ((title as NSString).length > 0 ) {
            self.labelView.text = title;
        }
        
        // Subtitle
        if ((subTitle as NSString).length > 0) {
            self.labelViewDescription.text = subTitle;
        }
        
        // Alert view colour and images
        self.circleView.backgroundColor = viewColor;
        
        // Adding duration
        if (duration != nil && duration > 0) {
            durationTimer?.invalidate()
            durationTimer = NSTimer.scheduledTimerWithTimeInterval(duration!, target: self, selector: Selector("hideView"), userInfo: nil, repeats: false)
        }
        
        // Animate in the alert view
        UIView.animateWithDuration(0.2, animations: {
            self.shadowView.alpha = self.kDefaultShadowOpacity
            var frame:CGRect = self.frame;
            frame.origin.y = self.rootViewController.view.center.y - 100;
            self.frame = frame;
            self.alpha = 1;
            }, completion: { finished in
                UIView.animateWithDuration(0.2, animations: {
                    self.center = self.rootViewController.view.center;
                    }, completion: { finished in })
            })
        
        // Chainable objects
        return BHAlertViewClose(alertview: self)
    }
    
    // When click 'Done' button, hide view.
    func doneButtonAction() {
        if(self.alertType=="pubSuccess"){
            indexCon()
        }else if(self.alertType=="alertDoIt"){
            doItDone()
        }else if(self.alertType=="alertComment"){
            commentDone()
        }else if self.alertType=="alertFinish"{
            finishItDone()
        }else if self.alertType=="alertLogin"{
            Login()
        }else if self.alertType=="signOut"{
            signOut()
        }
        hideView()
    }
    
    func closeAlert(){ hideView(); }
    
    // Close BHAlertView
    func hideView() {
        UIView.animateWithDuration(0.2, animations: {
            self.shadowView.alpha = 0;
            self.alpha = 0;
            }, completion: { finished in
                self.shadowView.removeFromSuperview()
                self.removeFromSuperview()
            })
    }
    
    func indexCon(){
        var manageCon = ManageController()
        self.rootViewController.presentModalViewController(manageCon, animated:false)
    }
    
    func doItDone(){
        var id = self.cellData.objectForKey("id") as String
        var request = HTTPTask()
        let url = "http://mm.renren.com/task-apply"
        let applyid = toString(getDictionary("userInfo").objectForKey("userId"))
        let parametersDic:Dictionary<String,AnyObject> = ["id":id,"applyid":applyid]
        request.POST(url, parameters: parametersDic, success: {(response: AnyObject?) -> Void in
            // 跳转到详情内页
            var detailsCon = DetailsController()
            detailsCon.id = id.toInt()!
            self.conView.presentModalViewController(detailsCon, animated:true)
        },failure: {(error: NSError) -> Void in
            UIView.showAlertView("提示",message:"加载失败")
        })
    }
    
    func finishItDone(){
        var id = self.cellData.objectForKey("id") as String
        var request = HTTPTask()
        let url = "http://mm.renren.com/task-done"
        let applyid = toString(getDictionary("userInfo").objectForKey("userId"))
        let parametersDic:Dictionary<String,AnyObject> = ["id":id,"applyid":applyid]
        request.POST(url, parameters: parametersDic, success: {(response: AnyObject?) -> Void in
            
//            var parent=self.tableCell.superview.superview as UITableView
//            parent.reloadData()
            var manageCon = ManageController()
            manageCon.initTab=1
            self.conView.presentModalViewController(manageCon, animated:false)
            
        },failure: {(error: NSError) -> Void in
            UIView.showAlertView("提示",message:"加载失败")
        })
    }
    
    func Login(){
        // 跳转到详情内页
        var userid=(self.cellData.objectForKey("id") as String).toInt()!
        var indexCon = ViewController()
        indexCon.getUserId=userid
        self.conView.presentModalViewController(indexCon, animated:true)
    }
    
    func commentDone(){
        // 跳转到详情内页
        var detailsCon = DetailsController()
        detailsCon.id = self.userId.toInt()!
        self.conView.presentModalViewController(detailsCon, animated:true)
    }
    
    func signOut(){
        var loginCon = LoginController()
        self.rootViewController.presentModalViewController(loginCon, animated:false)
    }
}