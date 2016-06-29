//
//  RunTimeViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/23.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "RunTimeViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "RTObj.h"
#import "RTObj1.h"

/**
 *  参考 
 *  http://www.jianshu.com/p/e071206103a4
 *  http://www.jianshu.com/p/46dd81402f63
 *
 *  有些字跟他们是一样的 我自己在打一遍 只是为了自己更好的理解
 
 
 *  runtime是运行时的语言 是系统运行时候的一些机制 主要是消息机制
    OC运行的时候也是转化成runtime来执行的 每一个OC的方法 底层必然有一个与之对应的runtime方法 方法的自己主要是消息发送 objc_msgsend
 
 *  OC是运行时机制   定义了方法 不去实现 编译的时候不会报错 但是如果在运行的时候调用它就会报错 编辑的时候不能决定真正调用的是哪一个方法 在运行时才通过方法名找对应的函数
 
 
 *  C是编译时机制    定义了方法 不去实现 编辑的时候就会报错 编辑的时候就觉得方法调用的是哪一个 直接顺序执行
 
 
     1. 动态的添加对象的成员变量和方法,修改属性值和方法
     2. 动态交换两个方法的实现
     3. 实现分类也可以添加属性
     4. 实现NSCoding的自动归档和解档
     5. 实现字典转模型的自动转换
     6. 动态创建一个类(比如KVO的底层实现)
 
 */



@interface RunTimeViewController ()

@end

@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //发送消息
    [self runtimeSendMsg];
    
    RTObj * obj = [RTObj new];
    
    /**
     *  获取属性列表
     */
    [obj getListProperty];
    
    /**
     *  获取方法列表
     */
    [obj getListMethod];
    
    /**
     *  获取成员变量列表
     */
    [obj getListIvar];
    
    /**
     *  获取协议列表
     */
    [obj getListProtocol];
    
    /**
     *  改变属性值
     */
    [self updatePropertyContent];
    
    
    /**
     *  动态添加方法
     */
    [self addMethodToRTObj];
    
    
    /**
     *  交换两个方法名对应的函数地址
     */
    [self exchangeMethod];
    
    
    /**
     *  拦截替换方法
     */
//    [self interceptMethod];
    
    /**
     *  动态添加属性
     */
    [self addPassValueProperty];
    
    [self getPassValueProperty];
    
    
    
    /**
     *  打印出字典数据中所有可设置的类型属性
     */
    [RTObj1 logAllPropertyAtDataDic:@{
                                      @"title":@"T_aaaa",
                                      @"status":@(0),
                                      @"success":@(YES),
                                      @"message":@"OK",
                                      @"cities":@[
                                              @{@"cn_name":@"成都市",
                                                @"name":@"cds",
                                                @"to_cities":@[
                                                        @{@"cn_name":@"成都市",
                                                          @"name":@"cds",
                                                          @"service_phone":@"10086"},
                                                        @{@"cn_name":@"中山市",
                                                          @"name":@"cds",
                                                          @"service_phone":@"10086"},
                                                        @{@"cn_name":@"龙岩市",
                                                          @"name":@"cds",
                                                          @"service_phone":@"10086"}
                                                        ]},
                                          ],
                                      @"config":@{@"pic":@"https:www.baidu.cn",
                                                  @"switch":@(NO)}
                                      
                                      }];
}

/**
 *  方法调用的本质 就是该所属的对象发消息
 *  objc_msgSend  只有对象才能发消息 所以以objc开头
 */
- (void)runtimeSendMsg
{
    RTObj * obj = [RTObj new];
    
    //我们一般调用方法都是 直接
    //直接调用对象方法  实质是 objc_msgSend(obj,@selector(test:));
    [obj test:@"self"];
    
    //会闪退 ......
//    [[RTObj class] test:@"class"];
    
}

#pragma mark - 修改属性值 -

/**
 *  改变属性值  设置成只读属性的值也可以更改.....
 *  m中的也能改 逆天
 */
- (void)updatePropertyContent
{
    RTObj * obj = [RTObj new];
    
    unsigned int count;
    Ivar * ivarList = class_copyIvarList([obj class], &count);
    for(unsigned int i = 0; i < count; i++)
    {
        Ivar var = ivarList[i];
        NSString * varName= [NSString stringWithUTF8String:ivar_getName(var)];
        if([varName isEqualToString:@"_itemName"])
        {
            object_setIvar(obj, var, @"季磊磊");
        }
        else if([varName isEqualToString:@"_itemContent"])
        {
            //只读的属性
            object_setIvar(obj, var, @"改变值了????");
        }
        else if ([varName isEqualToString:@"_itemDataList"])
        {
            NSLog(@"该属性的值 %@",object_getIvar(obj, var));
            
            //成员变量
            object_setIvar(obj, var, @[@"你完了",@"被人偷改了",@"怎么办",@"nothing"]);
        }
        else if ([varName isEqualToString:@"_itemSelectIndex"])
        {
            //m文件中的成员变量
            object_setIvar(obj, var, @(100));
            
            NSLog(@"m文件中的成员变量__%@",object_getIvar(obj,var));
        }
        else if ([varName isEqualToString:@"_itemDescription"])
        {
            //m文件中的属性
            object_setIvar(obj, var, @"描述描述描述描述描述描述描述");
            
            NSLog(@"m文件中的属性__%@",object_getIvar(obj,var));
        }
    }
    
    NSLog(@"___change property value name = %@, content = %@, list = %@",obj.itemName, obj.itemContent, [obj getDataList]);
}

#pragma - 动态添加方法 -

/**
 *  动态添加方法
 */
- (void)addMethodToRTObj
{
    /**
     *  去除警告
     http://www.jianshu.com/p/1465c2783241
     */
    
#pragma clang disgnotic push
    
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    RTObj * obj = [RTObj new];
    class_addMethod([obj class], @selector(addCount), (IMP)addCount, "v@:");
    
    if([obj respondsToSelector:@selector(addCount)])
    {
        [obj performSelector:@selector(addCount)];
    }
    else
    {
        NSLog(@"没有该方法");
    }
    
    //在RTObj中实现
    if([obj respondsToSelector:@selector(reloadRTData)])
    {
        [obj performSelector:@selector(reloadRTData)];
    }
    
    if([obj respondsToSelector:@selector(reloadRTData1)])
    {
        [obj performSelector:@selector(reloadRTData1)];
    }
    
    if([obj respondsToSelector:@selector(passRTValue:)])
    {
        [obj performSelector:@selector(passRTValue:) withObject:@"我要传字符串过去啦......完毕..."];
    }
    
//    [obj performSelector:@selector(passRTValue1:) withObject:@(223)];
    
//    [obj performSelector:@selector(passRTValue2:) withObject:@"我要传值过去......完毕..."];
//    
//    [obj performSelector:@selector(passRTValue3:) withObject:@"我要传值过去......完毕..."];
    
    
#pragma clang diagnostic pop
}

void addCount(id self, SEL _cmd)
{
    NSLog(@"动态添加了一个方法, 方法的实现写在这里...");
}


#pragma mark - 动态交换两个方法实现 -

/**
 *  交换两个方法名对应的函数地址   
 *  使用场景： 替换一些系统的方法实现 重新定义
 *  最后在类方法load中调用
 *  http://www.jianshu.com/p/4ded7ee15ec1
 */
- (void)exchangeMethod
{
    RTObj * obj = [RTObj new];
    
    NSLog(@"#### 交互之前 ####");
    
    [obj methodExchange1];
    [obj methodExchange2];
    
    Method m1 = class_getInstanceMethod([obj class], @selector(methodExchange1));
    Method m2 = class_getInstanceMethod([obj class], @selector(methodExchange2));
    
    method_exchangeImplementations(m1, m2);
    
    NSLog(@"#### 交互之后 ####");
    
    [obj methodExchange1];
    [obj methodExchange2];
    
    
    [obj methodExchange3];
    [obj methodExchange4];
}


//
///**
// *  拦截替换方法
// */
//- (void)interceptMethod
//{
//    RTObj * a = [RTObj new];
//    RTObj1 * b = [RTObj1 new];
//    
//    Class obj1 = object_getClass([RTObj class]);
//    Class obj2 = object_getClass([RTObj1 class]);
//    
//    Method method1 = class_getInstanceMethod(obj1, @selector(willBeInterceptMethod));
//    Method method2 = class_getInstanceMethod(obj2, @selector(doThisMethod));
//    
//    //先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
//    BOOL addSuccess = class_addMethod(obj1, @selector(willBeInterceptMethod), method_getImplementation(method2), method_getTypeEncoding(method2));
//    if(addSuccess)
//    {
//        class_replaceMethod(obj2, @selector(doThisMethod), method_getImplementation(method1), method_getTypeEncoding(method1));
//    }
//    else
//    {
//        method_exchangeImplementations(method1, method2);
//    }
//    
//    [a performSelector:@selector(willBeInterceptMethod)];
//}
//

#pragma mark - 动态添加属性

//本质是给这类添加这个属性的关联， 并不是把这个属性的内存空间添加到该类的空间中
char * const kPassvalue = "kRuntimeAddPropertyPassvalue";
char * const kNewProperty = "kRuntimeAddNewProperty";

- (void)addPassValueProperty
{
    objc_removeAssociatedObjects(self);
    
    objc_setAssociatedObject(self, kPassvalue, @"10086", OBJC_ASSOCIATION_COPY);
    
    self.newProperty = @"我是新添加的";
}

- (void)getPassValueProperty
{
    NSString * value = objc_getAssociatedObject(self, kPassvalue);
    
    NSLog(@"传递过来的值:%@ #### %@",value,self.newProperty);
}

- (NSString *)newProperty
{
    return objc_getAssociatedObject(self, kNewProperty);
}

-(void)setNewProperty:(NSString *)newPro
{
    objc_setAssociatedObject(self, kNewProperty, newPro, OBJC_ASSOCIATION_COPY);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
