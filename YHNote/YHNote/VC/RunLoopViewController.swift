//
//  RunLoopViewController.swift
//  YHNote
//
//  Created by 林宁宁 on 16/7/19.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

import UIKit

class RunLoopViewController: BaseViewController {

    /**
     
     参考：
     http://www.cocoachina.com/ios/20150601/11970.html
     http://blog.csdn.net/ztp800201/article/details/9240913
    
     一般来讲，一个线程一次只能执行一个任务，执行完之后就会推出线程。
     
     Runloop:loop是某种循环，和run就是表示一直运行着的循环。runloop和线程是紧密联系的，runloop是线程的基础构架部分，有些线程是一条直线，起点到终点，任务结束之后就退出线程。有些线程是做一个圆的操作，不断的循环，入操作系统，直到你关机，原型线程就是通过runloop不停的循环实现。
     
     主线程的runloop默认是启动的
     
     iOS 应用程序 OC 里面，会有一个main（）函数。重要是UIApplicationMain()函数，这个方法是为main thread设置一个 NSRunloop对象。这就是应用程序如果我们未做任何操作的时候，突然点击了界面上的一个按钮，对应的事件会马上触发，响应，随时待命。
     
     对于其他的线程来说，runloop默认是没有启动的。
     
     获取当前线程的runloop：  【NSRunloop currentRunLoop】
     
     NSRunLoop类不是线程安全的，我们不能在一个线程中操作另外一个线程的runloop对象，那可能会造成意想不到的后果，不过幸运的是CoreFoundation的不透明类CFRunLoopRef是线程安全的，通过CFRunLoop类可以达到线程安全的目的
     
     RunLoop管理并不是完全自动的，我们必须设计代码以在适当的时候启动Runloop并正确响应输入事件，前提是线程中需要使用到Runloop，而且，我们还需要使用while/for语句来驱动runloop能够循环运行，如：
     BOOL isRunning = NO;
     do{
        isRunning = [[NSRunLoop currentRunLoop]runMode: NSDefaultRunLoopMode before:[NSDate distantFuture]];
     }
     while(isRunning);
     
     
     runloop同时也负责autorelease pool的创建和释放，在使用手动的内存管理方式的项目中，会经常用到很多自动释放的对象，如果这些对象不嗯给你够被即时释放掉，会造成内存占用量急剧增大。Runloop就为我们做这样子的工作：每当运行一个循环结束的时候，他都会释放一次Autorelease pool，同时pool中的所有自动释放类型变量都会自动释放掉
     
     
     RunLoop的优点：一个RunLoop就是一个事件处理的循环，用来不停的监听和处理输入事件并将其分配到对应的目标上进行处理。RunLoop是一个高明的消息处理模式，在处理过程进行了更好的抽象和封装，NSRunLoop中每一个消息都会被打包在input source或者 timer source中
     使用runloop可以使你的线程在有工作的时候工作，没有工作的时候休眠，大大节省系统资源
     
     
     runloop的输入事件源：runloop输入事件源分为两种:输入源（input source）和定时源（timer source），两种源都使用程序的某一特定的处理例程来处理到达的事件.
     当你创建输入源的时候，需要将其分配给runloop中的一个或多个模式，模式只会在特定的时间影响监听源。大多数情况下，runloop运行在默认模式下，但是你也可以使其运行在自定义模式。若某一源在当前模式下不被监听，那么任何其生成的消息只在runloop运行在其关联的模式下才会被传递。
     
     
     输入源（input source）：传递异步事件，通常消息来自其他线程或程序。输入源传递异步消息给相应的处理例程，并调用runUntilDate：方法来退出
     
     基于端口的输入源：基于端口的输入源由内核自动发送，Cocoa 和 Core Foundation 内置支持使用端口相关的对象和函数来创建的基于端口的源，例如，在cocoa里面你从来不需要直接创建输入源。你只要简单的创建端口对象，并使用NSPort的方法把端口添加到runloop，端口对象会自己处理创建和配置输入源。在coreFoundation，你必须人工创建端口和他的runloop源，我们可以使用端口相关的函数，来创建合适的对象。
     
     自定义输入源：自定义输入源需要人工从其他线程发送，为了创建自定义输入源，必须使用core foundation里面的CFRunLoopSourceRef类型相关的函数来创建，你可以使用回调函数来配置自定义输入源。COreFoundation 会在配置源的不通地方调用回调函数，处理输入事件，在源从runloop一处的时候清理他
     
     
     Cocoa上的Selector源：除了基于端口的源，cocoa定义了自定义的输入源，允许你在任何线程执行selector方法，和基于端口的源一样，执行selector请求会在目标线程上序列化，减缓许多在线程上允许多个方法容易引起的同步问题，不像基于端口的源，一个Selector执行完后会自动从runloop里面移除，
     当其他线程上面执行Selector时，目标线程须有一个活动的runloop。对于你创建的线程，这意味着线程在你显示的启动runloop之前不会执行Selector方法的
     NSobject类提供了类似如下的Selector方法：
     - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)argwaitUntilDone:(BOOL)wait modes:(NSArray *)array;
     
     
     
     定时源（timer source）
     定时源在预设的时间点同步方式传递消息，这些消息都会发生在特定时间或者重复的时间间隔。定时源则直接传递消息给处理例程，不会立即退出runloop
     
     需要注意的是，尽管定时器可以产生基于时间的通知，但它不是实时机制。和输入源一样，定时器也和你的runloop的特定模式相关。如果定时器所在的模式未被runloop监视，那么定时器将不会开始知道runloop运行在相应的模式下，类似的。如果定时器在runloop处理某一事件期间开始，定时器会一直等待知道下次runloop开始相应的处理程序，如果runloop不再运行，那定时器将永远不启动。
     
     runloop观察者：源是在合适的同步或异步事件发生时触发，而runloop观察者则在runloop本身运行的特定时候触发。你可以使用runloop观察者来为处理某一特定事件或是进入休眠的线程做准备，
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let timer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(self.backgroundThreadFire) , userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    
    
    func backgroundThreadFire(){
        
        print("runloop timer");
        
    }
    
    
    
    
}







































