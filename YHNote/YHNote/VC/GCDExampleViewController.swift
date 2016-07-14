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
        
        super.viewDidLoad()
        
        gcdSemaphore()
        
    }
    
    
    /**
     Semaphore 信号量
     */
    func gcdSemaphore(){
        
         /**
         http://www.w2bc.com/Article/16104
         
         信号量控制访问资源的数量，比如系统有两个资源可以利用，同时又三个线程要访问，只能允许两个线程访问，第三个应当等待资源被释放之后再访问
         
         GCD中只要调度的线程在信号量不足的时候才会进入内核态进行线程阻塞
         
         dispatch_semaphore_create 创建
         dispatch_semaphore_signal 发送信号 + 1 信号总量加1 执行完
         dispatch_semaphore_wait   等待 -1 信号总量小于0就会一直等待，否则正常执行，并让信号总量-1
         
         先wait再signal
         
         */
        
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
        
        dispatch_async(dispatch_get_main_queue()) { 
            
        }
        
    }
    
}


















