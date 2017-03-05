//
//  HomeViewController.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/11.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableview : UITableView!
    var list: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        self.title = "Swift"
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        
        self.tableview = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "homeTableViewCellIdentify")
        self.view.addSubview(tableview)
        

        list = [
            ["title":"基础知识","vc":"SwiftBaseNoteViewController"],
            ["title":"目录结构-沙盒机制","vc":"DirectoryStructureViewController"],
            ["title":"数据持久化","vc":"DataPersistenceViewController"],
            ["title":"GCD","vc":"GCDExampleViewController"],
            ["title":"Encryption加密","vc":"SectureViewController"],
            ["title":"Popping动画","vc":"PoppingAnimationViewCtrl"]
            ["title":"RunLoop学习","vc":"RunLoopViewController"]
        ].copy() as! NSArray
        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCellWithIdentifier("homeTableViewCellIdentify", forIndexPath: indexPath) as UITableViewCell
     
        let dic = list[indexPath.row] as? NSDictionary
        
        cell.textLabel?.text = dic!["title"] as? String
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dic = list[indexPath.row] as? NSDictionary
        let vcStr = dic!["vc"] as? String
        
        let appName = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        let vcClass : AnyClass = NSClassFromString(appName + "." + vcStr!)!
        
        let vc = (vcClass as! UIViewController.Type).init()
        
        vc.title = dic!["title"] as? String
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
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
