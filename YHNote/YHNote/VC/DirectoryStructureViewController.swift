//
//  DirectoryStructureViewController.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/12.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

import UIKit

class DirectoryStructureViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /**
         
         参考-http://www.cocoachina.com/ios/20150720/12610.html
         
         沙盒-iOS程序默认情况下只能访问程序自己的目录 这个目录成为‘沙盒’
         
         沙盒的结构
         
         1.应用程序包
         
         2.Documents
         
         3.Library
         
          3.1-cache
         
          3.2-preference
         
         4.tmp
         
         */
        
        
        //每个目录都有自己的特性 存放目录的时候要认真选择合适的目录
        
        /**
         应用程序包：里面存放应用程序的源文件，包括资源文件和可执行文件
         */
        let pathPackage = NSBundle.mainBundle().bundlePath
        print("\n====\n应用程序包\(pathPackage)")
        
        /**
         Documents：最常用的目录，iTunes同步该应用时会同步此文件夹中的内容，适合储存重要数据
         */
        let documents = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).firstObject
        print("\n====\ndocuments\(documents)")
        
        /**
         Library/cache：iTunes不会同步次文件夹，适合存储体积大的 不需要备份的非重要的数据
         */
        let cache = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).firstObject
        print("\n====\nlibrary/cache\(cache)")
        
        /**
         Library/Preference：iTunes同步该应用的时候会同步此文件夹中的内容，通常保存应用的设置信息
         */
        let preference = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.PreferencePanesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).firstObject
        print("\n====\nlibrary/preference\(preference)")
        
        /**
         tmp:iTunes不会同步此文件夹，系统可能会在应用没运行的时候就删除该目录下的文件，所以此目录适合保存应用中的一些临时文件，用完就删除
         */
        let tmp = NSTemporaryDirectory()
        print("\n====\ntmp\(tmp)")
        
        
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
