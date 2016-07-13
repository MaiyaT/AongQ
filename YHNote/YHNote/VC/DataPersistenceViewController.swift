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
         
         参考
         http://www.cocoachina.com/ios/20150720/12610.html
         
         */
        

        let documentStr : NSString = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).firstObject as! NSString
        
        print("document : \(documentStr)")
        
        //testPlistWithPath(documentStr)

        //testPreferenceWithPath(documentStr)
        
        //testKeyedArchiver(documentStr)
    }

    func testSQLite3(document:NSString){
        
        print("############### SQLite3 ###############")
        
        /**
         
         plist,nskeyedarchive,proferenced都是覆盖储存的，先到把整个数据读出来，然后修改数据之后再把整个存储，不适合存储大量的内容，就需要使用SQLite
         
         SQLite数据类型分为：
         
         integer：整数
         real：实数
         text：文本字符串
         blob：二进制文件，比如文件，图片之类
         
         SQLite是无类型的，即不不管你在建表时指定的类型是什么什么，存储依然可以存储任的数据。而且在建表的时候可以不指定字段类型。SQLite之所以什么类型都可以是为了良好的编程规范和方便开发人员交流，所以平时使用的时候最好设置正确的字段类型，主键要设置成integer
         
         */
    }
    
    func testKeyedArchiver(documentStr:NSString){
        
        print("############### NSKeyedArchiver ###############")
        
        /**
         
         归档时iOS中另外一种形式的序列化，只需要遵守NSCoding协议的对象就可以通过他实现序列化。
         
         有两个方法必须实现：encode decode
         
         */
        
        //保存文件的扩展名可以任意指定
        //继承时必须先调用父类的归档解档方法
        
        //归档保存的路径
        let archiverPath = documentStr.stringByAppendingPathComponent("archiver.data")
        
        let archiverData = NSKeyedUnarchiver.unarchiveObjectWithFile(archiverPath) as? Person
        
        if(archiverData == nil){
            
            let person = Person()
            person.age = 100
            person.name = "sssss"
            person.icon = UIImage.init(named: "ticket")
            
            NSKeyedArchiver.archiveRootObject(person, toFile: archiverPath)
        }
        
        
    }
    
    func testPreferenceWithPath(documentStr:NSString)
    {
        print("############### Preference ###############")
        
        /**
         
         偏好设置 NSUserDefault
         
         是专门用来保存应用程序的配置信息，一般不要在偏好设置中保存其他的数据
         
         如果没有调用synchronize方法 系统会根据i/o情况不定时刻保存到文件中，所以如果需要立即写入文件的就必须调用synchronize
         
         偏好设置会将所有是护具保存到同一文件中，即preference目录下的一个以此应用包名来命名的plist文件
         
         */
        
        
        //获取NSUserDefault文件
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        //写入数据
        userDefaults.setObject("AAA", forKey: "a")
        userDefaults.setBool(true, forKey: "sex")
        userDefaults.setInteger(32, forKey: "age")
        
        //同步
        userDefaults.synchronize()
        
        //读取数据
        print("###\(userDefaults.objectForKey("a"))###\(userDefaults.objectForKey("sex")?.boolValue)###\(userDefaults.objectForKey("age")?.intValue)")
    }
    
    
    func testPlistWithPath(documentStr:NSString){
        
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
        let plistSavePath = documentStr.stringByAppendingPathComponent("city.plist")
        
        print("save plst file path : \(plistSavePath)")
        
        plistList?.addObject(["city":"北京市","pingying":"beijingshi"])
        
        //存储本地
        plistList?.writeToFile(plistSavePath, atomically: true)
        
        
        //读取
        let plistGet = NSArray.init(contentsOfFile: plistSavePath)
        
        print("read plist data from local : \(plistGet)")
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



class Person: NSObject,NSCoding {
    
    var name : String?
    var age : Int?
    var icon : UIImage?
    
    //解档
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.age = aDecoder.decodeObjectForKey("age") as? Int
        self.icon = aDecoder.decodeObjectForKey("icon") as? UIImage
        
    }
    
    override init() {
        
    }
    
    //归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.age, forKey: "age")
        aCoder.encodeObject(self.icon, forKey: "icon")
    }
}



