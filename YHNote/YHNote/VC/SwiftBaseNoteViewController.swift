//
//  SwiftBaseNoteViewController.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/11.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

import UIKit

class SwiftBaseNoteViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        varFunction()
    }

    
    func varFunction(){
        
        /**
         参考：http://www.jianshu.com/p/22e2ad531b2f
         */
        
        //变量 可变
        var myVariable = 1
        myVariable = 3
        
        //常量 不可变
        let myConstant = 3
        
        //指定 变量或者常量的类型
        var name : String
        name = "Lilei"
        
        //字符串可以通过+连接在一起
        name = name + String(myVariable)+String(myConstant)
        
        NSLog("字符串连接在一起" + name)
        
        let userinfo = "my name is \(name), i am \(myVariable) years old"
        
        print("字符串中间出入值用`\\` \(userinfo)....")
        
        
        
        //？和！  http://blog.csdn.net/woaifen3344/article/details/30244201
        
        //定义变量的时候如果不对他赋初始值的话 后面如果使用到的话 则会报错 这个变量没有内存 
        //使用optional类型，后面跟一个？ 自动默认值为nil，这个nil和oc中的nil不同，不是指针，而是代表值不存在
        
        //在调用方法、属性、下标索引的时候前面需加上一个？，表示如果是nil值得花 ，也就是optional.None，跳过，后面操作不执行了，如果有值，就是Optional.Some 可能就会拆包，然后执行后面的操作
        
        var stringValue : String?
        
        let hashStr = stringValue?.hashValue
        
        //在写协议protocol时候 对于可选代理方法 也需要在调用的时候在函数名后跟着？
        var delegate : HttpRequestDelegate?
        
        
        //使用！ 是强制拆包 保证有值得情况下才使用
        
        stringValue = "！拆包。。。"
        
        if ((stringValue) != nil){
            let intrrr = stringValue!.hashValue
        }
        
        let integer = stringValue!.hashValue
        
        //使用！来声明 变量 会成为隐士式强制拆包可选类型 表示这个变量永远不会出现nil情况 在调用的时候不需要使用！ ？ 来说明
        
        var myLabel : UILabel!
        
        myLabel = UILabel(frame: CGRectMake(10,100,300,10))
        
        myLabel.text = "assss"
        
    
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



//@objc 是处理 swift和OC之间的转换 由于@optional是OC的关键字 所以在使用protocol之前需要添加上@objc
@objc protocol HttpRequestDelegate{
    
    optional func requestFinish(requset:NSURLRequest!, downloadData:NSMutableData)
    
}

