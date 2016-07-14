//
//  GCDExampleViewController.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/14.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

import UIKit

class GCDExampleViewController: BaseViewController {

    
    override func viewDidLoad() {
        
        gcdSemaphore()
        
    }
    
    
    /**
     Semaphore 信号量
     */
    func gcdSemaphore(){
        
        //创建信号量
        let sem : dispatch_semaphore_t = dispatch_semaphore_create(0)
        
        let queue : dispatch_queue_t = dispatch_queue_create("semaphore", nil)
        
        dispatch_async(queue) { 
            
            for i:Int in 0...10{
                print("Semaphore quque 1:\(i)")
            }
            
            dispatch_semaphore_signal(sem)
        }
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
        
        for i:Int in 0...10 {
            print("Semaphore quque 2:\(i)")
        }
    }
    
}


















