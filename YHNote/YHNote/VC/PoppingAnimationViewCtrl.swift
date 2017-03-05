//
//  PoppingAnimationViewCtrl.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/25.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

import UIKit

//https://github.com/facebook/pop
class PoppingAnimationViewCtrl: BaseViewController {

    
    
}


class PopItemV : UIView {
    
    var boxV : UIView?
    var labTitle : UILabel?
    
    func buildContent(){
        
        self.boxV = UIView()
        self.boxV?.backgroundColor = UIColor.redColor()
        self.addSubview(self.boxV!)
        
        self.labTitle = UILabel()
        self.labTitle?.textAlignment = NSTextAlignment.Center
        self.labTitle?.textColor = UIColor.blackColor()
        self.labTitle?.font = UIFont.systemFontOfSize(20)
        self.addSubview(self.labTitle!)
        
        self.boxV?.mas_makeConstraints({ (make : MASConstraintMaker!) in
            make.left.equalTo(self.boxV).offset(20)
            
            
        })
        
    }
    
}