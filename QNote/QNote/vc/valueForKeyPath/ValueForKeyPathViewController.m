//
//  ValueForKeyPathViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/4.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "ValueForKeyPathViewController.h"

@interface ValueForKeyPathViewController ()

@end

@implementation ValueForKeyPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // valueForKey objectForKey 在NSDictionary中取值
    // 他们的差异是 如果key已@开头
    // valueForKey 会自动把这个@去掉 比如 key是  @name 变成 name 但是字典中无此key 取值就会错误
    // valueForKey 实质是 KVC(NSKeyValueCoding) 的方法 通过property的名字来对应key
    // objectForKey 不做处理
    
    // valueforkey 只允许 NSString 的key
    // objectforkey 可以任意类型
    
    
    
    
    /**
     *  valueForKeyPath
     *  参考
     *
     *  http://www.jianshu.com/p/52b3563b298b
     */
    
    
    //############### 针对字典  #####################
    
    NSDictionary * dataDicKeyPath = @{@"key1":@1,
                                      @"key2":@2,
                                      @"key3":@3,
                                      
                                      @"lists":@{
                                              
                                              @"list1":@{
                                                      @"pic1":@"pic1111",
                                                      @"pic2":@"pic2222",
                                                      
                                                      @"url":@[@"111111111",
                                                               @"222222222",
                                                               @"333333333"]
                                                      },
                                              
                                              
                                              @"list2":@{
                                                      @"pic1":@"pic1111",
                                                      @"pic2":@"pic2222",
                                                      @"pic1":@"pic1111",
                                                      @"pic2":@"pic2222",
                                                      }
                                              }
                                      
                                      };
    

    
    NSLog(@"lists.list2 === %@",[dataDicKeyPath valueForKeyPath:@"lists.list2"]);
    
    NSLog(@"lists.list2.pic2 === %@",[dataDicKeyPath valueForKeyPath:@"lists.list2.pic2"]);
    
    
    
    
    //会闪退 找不到这个keypath
//    NSLog(@"lists.list2.pic2.pic3 === %@",[dataDicKeyPath valueForKeyPath:@"lists.list2.pic2.pic3"]);
//    NSArray * pic3List = [dataDicKeyPath mutableArrayValueForKeyPath:@"lists.list2.pic2.pic3"];
//    if(pic3List)
//    {
//        NSLog(@"lists.list2.pic2.pic3 === %@",[dataDicKeyPath valueForKeyPath:@"lists.list2.pic2.pic3"]);
//    }
//    
//    if([dataDicKeyPath mutableArrayValueForKeyPath:@"lists.list1.url"].count > 0)
//    {
//        NSLog(@"lists.list1.url === %@",[dataDicKeyPath valueForKeyPath:@"lists.list1.url"]);
//    }
    
    
    
     //############### 针对数组  #####################
    
    NSArray * dataList = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    
    __unused NSNumber * sum = [dataList valueForKeyPath:@"@sum.floatValue"];
    __unused NSNumber * avg = [dataList valueForKeyPath:@"@avg.floatValue"];
    __unused NSNumber * max = [dataList valueForKeyPath:@"@max.floatValue"];
    __unused NSNumber * min = [dataList valueForKeyPath:@"@min.floatValue"];
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
