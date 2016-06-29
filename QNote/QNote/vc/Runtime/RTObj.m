//
//  RTObj.m
//  QNote
//
//  Created by 林宁宁 on 16/6/23.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "RTObj.h"
#import <objc/runtime.h>

@interface RTObj()
{
    NSInteger _itemSelectIndex;
    
}

@property (copy, nonatomic) NSString * itemDescription;

@end

@implementation RTObj

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _itemDataList = @[@"不要动我",@"不开玩笑！"];
    }
    return self;
}

- (void)test:(NSString *)str
{
    NSLog(@"######test_%@",str);
}

- (void)readDataFromLocal
{

}

- (void)saveDataToLocal
{

}




/**
 *  获取属性列表
 */
- (void)getListProperty
{
    NSMutableString * propertyStr = [[NSMutableString alloc] init];
    
    unsigned int count;
    objc_property_t * propertyList = class_copyPropertyList([self class], &count);
    for(unsigned int i = 0; i < count; i++)
    {
        const char * propertyName = property_getName(propertyList[i]);
        
        NSString * name = [NSString stringWithUTF8String:propertyName];
        
        [propertyStr appendFormat:@"\n%@",name];
    }
    
    NSLog(@"___property___%@",propertyStr);
}


/**
 *  获取成员变量列表
 */
- (void)getListIvar
{
    NSMutableString * ivarStr = [[NSMutableString alloc] init];
    
    unsigned int count;
    Ivar * ivarList = class_copyIvarList([self class], &count);
    for(unsigned int i = 0; i < count; i++)
    {
        NSString * ivar = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        [ivarStr appendFormat:@"\n%@",ivar];
    }
    NSLog(@"___ivar___%@",ivarStr);
}


/**
 *  获取方法列表
 */
- (void)getListMethod
{
    NSMutableString * methodStr = [[NSMutableString alloc] init];
    
    unsigned int count;
    Method * methodList = class_copyMethodList([self class], &count);
    for(unsigned int i = 0; i < count; i++)
    {
        [methodStr appendFormat:@"\n%@",NSStringFromSelector(method_getName(methodList[i]))];
    }
    
    NSLog(@"___method___%@",methodStr);
}

/**
 *  获取协议列表
 */
- (void)getListProtocol
{
    NSMutableString * protocolStr = [[NSMutableString alloc] init];
    
    unsigned int count;
    Protocol * __unsafe_unretained * protocolList = class_copyProtocolList([self class], &count);
    for(unsigned int i = 0; i < count; i++)
    {
        const char * protocolName = protocol_getName(protocolList[i]);
        
        [protocolStr appendFormat:@"\n%@",[NSString stringWithUTF8String:protocolName]];
    }
    
    NSLog(@"___protocol___%@",protocolStr);
}

- (NSArray *)getDataList
{
    return _itemDataList;
}


+ (double)getCellheight
{
    return 19;
}



-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.itemID = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"itemID"];
        
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemID forKey:@"itemID"];
}

+(BOOL)supportsSecureCoding
{
    return YES;
}



#pragma mark - 通过runtime动态添加方法 -


/**
 
 参考：http://www.jianshu.com/p/60773495dc1e
 动态添加方法
 运用的就是 . 懒加载
 
 使用场景：
 1.如果 一个类的方法有很多，加载类的时候就比较耗加载资源， 这样子就可以分步加载了
 2.可以在该类m中是实现该方法也可以在其他类中 试了一下 是可以的 
 3.如果这个该类的函数没有在h文件中声明 其他的类就调用不到这个方法了 但是用动态方法添加其他类可以调用的到 声明了 其他类通过performSelector调用
 4.听说面试很多都会问到这个问题  你有没有用到过performSelector 其他就是问你有没有用过runtime动态添加方法
 
 
 参数1：要添加方法的类
 参数2：要添加的方法名
 参数3：该添加方法名对应的地址指针 函数地址
 参数4：方法的类型：返回值+参数类型

 c  A char
 i  An int
 s  A short
 l  A long l is treated as a 32-bit quantity on 64-bit programs.
 q  A long long
 C  An unsigned char
 I  An unsigned int
 S  An unsigned short
 L  An unsigned long
 Q  An unsigned long long
 f  A float
 d  A double
 B  A C++ bool or a C99 _Bool
 v  A void
 *  A character string (char *)
 @  An object (whether statically typed or typed id)
 #  A class object (Class)
 :  A method selector (SEL)
 [array type]  An array
 {name=type...}  A structure
 (name=type...)  A union
 bnum  A bit field of num bits
 ^type  A pointer to type
 ?  An unknown type (among other things, this code is used for function pointers)
 
 */

/**
 
 当对象调用未实现的方法的时候  会调用这个方法处理
 通过sel判断该方法是否需要动态添加他的实现方法
 
 */
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if(sel == @selector(reloadRTData))
    {
        //动态添加方法
        
        
        class_addMethod([self class], @selector(reloadRTData), (IMP)reloadRTData, "v@:");
    }
    else if (sel == @selector(passRTValue:))
    {
        class_addMethod(self, sel, (IMP)passRTValue, "v@:@");
    }
//    else if (sel == @selector(passRTValue1:))
//    {
//        class_addMethod(self, sel, (IMP)passRTValue1, "v@:i");
//    }
    
//    NSLog(@"___####___%@",NSStringFromSelector(sel));
    
    return [super resolveInstanceMethod:sel];
}

- (void)reloadRTData1
{
    NSLog(@"test reloadRTData1");
}


/**
 *  前面两个参数 一个self 和 _cmd是隐藏参数  OC每一个的每一个方法都有
 *
 *  @param self 对象本身
 *  @param _cmd 方法名本身
 
 
 */

void reloadRTData(id self, SEL _cmd)
{
    NSLog(@"添加了 reloadRTData方法###%@",NSStringFromSelector(_cmd));
}



void passRTValue(id self, SEL _cmd, NSString * message)
{
    NSLog(@"passValue is %@",message);
}

//void passRTValue1(id self, SEL _cmd, int index)
//{
//    NSLog(@"passValue is %d",index);
//}



- (void)methodExchange1
{
    NSLog(@"do exchange %@___1",NSStringFromSelector(_cmd));
}

- (void)methodExchange2
{
    NSLog(@"do exchange %@___2",NSStringFromSelector(_cmd));
}



- (void)methodExchange3
{
    NSLog(@"do exchange %@___3",NSStringFromSelector(_cmd));
}

- (void)methodExchange4
{
    NSLog(@"do exchange %@___4",NSStringFromSelector(_cmd));
}



+(void)load
{
    Method m1 = class_getInstanceMethod([self class], @selector(methodExchange3));
    Method m2 = class_getInstanceMethod([self class], @selector(methodExchange4));
    
    method_exchangeImplementations(m1, m2);
}


@end
