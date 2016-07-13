//
//  DBUnit.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/13.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

import UIKit
import Foundation


class DBUnit: NSObject {

    var _sqlite3 : COpaquePointer = nil
    
    func openDataBase(){
        
        //数据库的路径
        let filename = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent("yh.db")
        
        //打开数据库文件 如果没有该文件会自动创建一个文件
        let result = sqlite3_open(filename, &_sqlite3)
        if(result == SQLITE_OK){
            //打开数据库成功
            //创建一个数据表
            sqlite3_exec(_sqlite3, "CREATE TABLE IF NOT EXISTS t_person(id integer primary key autoincrement, name text, age integer)", nil, nil, nil)
        }
    }
    
    
    //使用 sqlite3_exec 来执行SQL语句，比如创建表，更新，插入，删除操作。但是一般不用他来执行查询语句，一般不是返回查询的结果
    
    //插入
    func insertData(){
        var nameStr : String
        var age : Int
        
        for i in 0..<1000{
            nameStr = "Bourne=\(arc4random_uniform(10000))"
            age = Int(arc4random_uniform(80)) + 20
            
            let sql = "INSERT INTO t_person (name, age) VALUES('\(nameStr)', '\(age)')"
            
            sqlite3_exec(_sqlite3, sql, nil, nil, nil)
        }
    }
    
    //查询一般不用sqlite_exec() 查询需要数据返回必须要获得查询结果
    /**
     
     sqlite3_prepare_v2()  检查sql的合法性
     sqlite3_step()  逐步获取查询结果 不断重复 直到最后一条
     sqlite3_coloum_xxx()  获取对应类型的内容，根据实际查询字段的属性，使用sqlite3_column_xx取得对应的内容即可
     sqlite3_finalize()  释放stmt
     
     */
    func readData() -> NSArray {
        let list : NSMutableArray = NSMutableArray()
        let sql = "SELECT name, age FROM t_person;"
        
        var stmt : COpaquePointer = nil
        
        let result = sqlite3_prepare_v2(_sqlite3, sql, -1, &stmt, nil)
        
        if result == SQLITE_OK{
            while sqlite3_step(stmt) == SQLITE_ROW {
                let name = String(sqlite3_column_text(stmt, 0))
                let age = Int(sqlite3_column_int(stmt, 1))
                
                let p : Person = Person()
                p.name = name
                p.age = age
                
                list.addObject(p)
            }
        }
        
        sqlite3_finalize(stmt)
        
        return list
    }
    
}

































