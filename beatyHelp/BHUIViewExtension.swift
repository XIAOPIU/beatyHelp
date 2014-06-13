//
//  BHUIViewExtension.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/12/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import UIKit
import Foundation

extension UIView  {
    func x()->CGFloat{
        return self.frame.origin.x
    }
    
    func right()-> CGFloat{
        return self.frame.origin.x + self.frame.size.width
    }
    
    func y()->CGFloat{
        return self.frame.origin.y
    }
    
    func bottom()->CGFloat{
        return self.frame.origin.y + self.frame.size.height
    }
    
    func width()->CGFloat{
        return self.frame.size.width
    }
    
    func height()-> CGFloat{
        return self.frame.size.height
    }
    
    func setX(x: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    func setRight(right: CGFloat){
        var rect:CGRect = self.frame
        rect.origin.x = right - rect.size.width
        self.frame = rect
    }
    
    func setY(y: CGFloat){
        var rect:CGRect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    func setBottom(bottom: CGFloat){
        var rect:CGRect = self.frame
        rect.origin.y = bottom - rect.size.height
        self.frame = rect
    }
    
    func setWidth(width: CGFloat){
        var rect:CGRect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func setHeight(height: CGFloat){
        var rect:CGRect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    
    class func showAlertView(title:String,message:String){
        var alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle("好")
        alert.show()
        
    }
}
