//
//  HomeViewController.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/11.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
        

        list = [
            ["title":"基础知识","vc":"SwiftBaseNoteViewController"]
        ].copy()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let identifyCell : String = "homeTableViewCellIdentify";
        let cell = tableview.dequeueReusableCellWithIdentifier("homeTableViewCellIdentify", forIndexPath: indexPath) as UITableViewCell
     
        let dic = list[indexPath.row]
        
        cell.textLabel?.text = dic["title"]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dic = list[indexPath.row]! as NSDictionary
        
        let vcClass = NSClassFromString(dic["vc"]? as String)
        
        let vc = vcClass() as UIViewController
        
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
