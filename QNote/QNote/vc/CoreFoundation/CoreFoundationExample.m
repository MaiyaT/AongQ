//
//  CoreFoundationExample.m
//  QNote
//
//  Created by 林宁宁 on 16/7/5.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "CoreFoundationExample.h"

/**
 
 参考链接：
 
 https://developer.apple.com/library/ios/documentation/CoreFoundation/Reference/CoreFoundation_Collection/index.html
 
 http://www.udpwork.com/item/10889.html
 
 CF框架是C语言实现的，不是OC
 
 如果用到CF的话需要手动管理内存
 
 CF提供了基本的功能，CFString，CFData，CFNumber。
 
 
 
 __bridge 用于Objective-C和Core Foundation指针之间的转换，这种转换不会更换对象的所有权（ownership）。
 __bridge_retained 或 CFBridgeRetain 用于从Objective-C到Core Foundation的指针转换，并且会将对象的所有权（ownership）转移，所以你需要在不再使用该对象的时候调用CFRelease方法来解除引用。
 __bridge_transfer 或 CFBridgeRelease 用于将非Objective-C指针转换为Objective-C指针，对象的所有权（ownership）会交给ARC，这时你无须担心对象何时释放，交给ARC去做就好了。
 
 
 */

@implementation CoreFoundationExample


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //__bridge只是在CF和OC之间传递的指针，其他事都没干，所以CF转成OC之后，还要手动释放内存
    
    CFStringRef aCFString = CFStringCreateWithCString(NULL, "ttexttt", kCFStringEncodingASCII);
    
    NSString * aNSString = (__bridge NSString *)aCFString;
    
    NSLog(@"__bridge CF change to OC %@  ",aNSString);
    
    CFRelease(aCFString);
    
    
    //__bridge_retained或者CFBridgeRetain(),将Objective-C对象转换成Core Foundation对象，把对象所有权桥接给CF对象，同事比多ARC的管理权，需要手动释放内存
    
    
        
}

@end
