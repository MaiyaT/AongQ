//
//  PropertyKeyWordVController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/3.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "PropertyKeyWordVController.h"

/*
 参考：
 http://www.jianshu.com/p/e3c99b426492
 
 iOS7 CookBook精彩瞬间（一）property、selector细节、__unused
 http://www.bubuko.com/infodetail-1069958.html
 
 */

@interface PropertyKeyWordVController ()

@property (nonatomic, strong) NSObject * obj1;
@property (nonatomic, strong) NSObject * obj2;

@property (nonatomic, strong) NSObject * obj3;
@property (nonatomic, weak) NSObject * obj4;


@property (nonatomic, strong, nonnull) NSObject * obj5;
@property (nonatomic, strong) NSObject * __nonnull obj6;
@property (nonatomic, strong, nullable) NSObject * obj7;
@property (nonatomic, strong) NSObject * __nullable obj8;


@end

@implementation PropertyKeyWordVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //====== 强引用，对象的引用计数器值+1 ======"
    
    self.obj1 = [NSObject new];
    self.obj2 = self.obj1;
    NSLog(@"obj1 = %@ , obj2 = %@",self.obj1,self.obj2);
    //obj1 = <NSObject: 0x7fc8f0724870> , obj2 = <NSObject: 0x7fc8f0724870>
    self.obj1 = nil;
    NSLog(@"obj1 = %@ , obj2 = %@",self.obj1,self.obj2);
    //obj1 = (null) , obj2 = <NSObject: 0x7fe969648870>
    
    
    
    //====== 弱引用，如果持有对象被释放，该对象也自动释放 ======"
    
    self.obj3 = [NSObject new];
    self.obj4 = self.obj3;
    NSLog(@"obj3 = %@ ,obj4 = %@",self.obj3,self.obj4);
    //obj3 = <NSObject: 0x7fc8f07255c0> ,obj4 = <NSObject: 0x7fc8f07255c0>
    self.obj3 = nil;
    NSLog(@"obj3 = %@ ,obj4 = %@",self.obj3,self.obj4);
    //obj3 = (null) ,obj4 = (null)
    
    
//    id __weak obj = [NSObject new];
//    NSLog(@"%@",obj);
    
    
    //6.3 XCode的时候 一个OC特性 nullability
    
    /**
     *  __nullable
     *
     *  表示一个可以是NULL 或者 nil的空值
     */
    
    /**
     *  __nonnull
     *
     *  表示一个不能为空的 值  方法传参的时候可以进行限制
     */
    
    //带下划线修饰在后面 在前面修饰不带下划线
    
    [self daydayStudy1:@"base oc"];
    [self daydayStudy2:@"null oc"];
    
    [self daydayStudy3:nil];
    [self daydayStudy4:@"zero"];


//    self.obj5 = nil;
//    self.obj6 = nil;
//    self.obj7 = nil;
//    self.obj8 = nil;
    
    
    //nonatomic 是非线程安全  多线程修改的时候不加锁，可能会出现多个线程先后修改之后数据错乱 脏数据
    
    //unsafe  unretained   和 assign作用一样   如果是修饰对象 这个property只是指向数据的指针 跟weak一样作用
    
    //指针指向的数据 如果释放了 weak这个指针也自动变成nil 但是assign 不会****
    
    //copy 和 strong 都是使计数+1
    
    // NSString 使用 copy 和 strong 是没有差别的 都是指向同一地址 copy是浅拷贝
    // NSMutableString strong是计数+1 没有新的内存空间  copy深拷贝 有新的内存地址
    
    //
    
    // __unused 是告诉编译器 如果变量未使用 不参与编译 不然有警告
    __unused UIButton * btn = [UIButton new];
    
    
    
    
    
    
    
}


- (void)daydayStudy1:(NSString * __nonnull)language
{
    NSLog(@"#####%@",language);
    
}

- (void)daydayStudy2:(nonnull NSString *)language
{
    NSLog(@"#####%@",language);
}

- (void)daydayStudy3:(NSString * __nullable)language
{
    NSLog(@"#####%@",language);
}

- (void)daydayStudy4:(nullable NSString *)language
{
    NSLog(@"#####%@",language);
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
