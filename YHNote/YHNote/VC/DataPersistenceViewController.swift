//
//  DataPersistenceViewController.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/12.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

import UIKit

class DataPersistenceViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /**
         数据持久化：
         Plist
         NSKeyedArchive（归档）
         SQLite3
         CoreData
         Preference
         */
        
        let documentStr = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        print("############### Plist ###############")
        
        /**
         Plist文件是将某些特定的类，通过XML文件的方式保存在目录中
         可序列化的类型只有如下几种：
         NSArray
         NSMutableArray
         NSDictionary
         NSMutableDictionary
         NSData
         NSMutableData
         NSString
         NSMutableString
         NSNumber
         NSDate
         */
        
        //获取文件的路径
        let pathPlist  = NSBundle.mainBundle().pathForResource("CityPlist", ofType: "plist")
        
        let plistList = NSMutableArray.init(contentsOfFile: pathPlist!)
        
        print("\n=====\nplist\(plistList)")
        
        //获取Document下目录
        let plistSavePath = NSURL(fileURLWithPath: "\(documentStr)").URLByAppendingPathComponent("city.plist")
        
        //("\(documentStr)" as NSString).stringByAppendingPathComponent("city.plist")
        
        print("save plst file path : \(plistSavePath)")
        
        plistList?.addObject(["city":"北京市","pingying":"beijingshi"])
        
        //存储本地
        plistList?.writeToFile(plistSavePath.absoluteString, atomically: true)
        
        
        //读取
        let plistGet = NSArray.init(contentsOfFile: plistSavePath.absoluteString)
        
        print("read plist data from local : \(plistGet)")
        
        ...
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
