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
 */

@interface PropertyKeyWordVController ()

@property (nonatomic, strong) NSObject * obj1;
@property (nonatomic, strong) NSObject * obj2;

@property (nonatomic, strong) NSObject * obj3;
@property (nonatomic, weak) NSObject * obj4;

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
