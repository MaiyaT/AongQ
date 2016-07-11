//
//  CoreDataExampleVController.m
//  QNote
//
//  Created by 林宁宁 on 16/7/7.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "CoreDataExampleVController.h"
#import "CoreDataManaged.h"
#import "CDObj.h"
#import "AppDelegate.h"

@interface CoreDataExampleVController ()



@end

@implementation CoreDataExampleVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     
     Core Data 是一个模型层技术
     Core Data 不仅是一个加载 保存数据的框架 他还能和内存中的数据很好的共事
     Core Data 提供的最强大的功能之一是他的对象图形管理
     Core Data ORM框架+objects graph 他可以选择sqlist，xml，plist或其他方式作为持久化方案
     
     Core Data 是一种持久化技术 他能将模型对象的状态持久化到磁盘。Core Data帮助你建立代表程序状态的模型层
     
     
     如果你需要其他功能 比如redo，undo，数据验证，或者方便的icloud等额外贡呢，就选择codedata
     
     */
    
    
    /**
     
     参考：http://www.tuicool.com/articles/ZfmAJnN
     
     NSManagedObjectContext:负责应用和数据库之间的交互，对象的上下文
     
     NSPersistentStoreCoordinator:添加持久化数据库（如SQLite 数据库），物理数据储存的物理文件和程序之间的联系的桥梁，负责管理不同对象的上下文
     
     NSManagedObjectModel：被管理的对象模型
     
     NSEntityDescription：实体描述
     
     
     如果新建项目的时候没有勾选CoreData
     参考：http://cnbin.github.io/blog/2016/03/11/ios-zai-yi-you-xiang-mu-tian-jia-coredata/
     
     参考：http://cnbin.github.io/blog/2016/03/11/iosshi-yong-coredata/
     
     http://www.jianshu.com/p/5e8e8517a00c
     
     */
    
    
    
    //创建数据 create entity
    
    
//    //添加一个对象
//    CDObj *classes = [NSEntityDescription insertNewObjectForEntityForName:@"CDObj" inManagedObjectContext:managedObjectContext];
//    classes.userName = @"jay";
//    classes.userID = @"高三(1)班";
//    NSError *error;
//    //保存上下文,这里需要注意，增、删、改操作完最后必须调用管理对象上下文的保存方法，否则操作不会执行。
//    if (![managedObjectContext save:&error]) {
//        NSLog(@"添加过程中发生错误,错误信息：%@！",error.localizedDescription);
//    }
//
    
    
    
//    NSManagedObjectContext * manageObjectContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
//    
//    NSEntityDescription * entity = [NSEntityDescription entityForName:@"CDObj" inManagedObjectContext:manageObjectContext];
//    
//    NSManagedObject * record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:manageObjectContext];
//    
//    [record setValue:@"Jay" forKey:@"name"];
//    
//    NSError * error1;
//    
//    if([manageObjectContext save:&error1])
//    {
//        NSLog(@"保存成功");
//    }
//    else
//    {
//        NSLog(@"保存失败 %@",error1);
//    }
    
    
    
    
    
    UIView * lineDotV = [[UIView alloc] initWithFrame:CGRectMake(20, 150, CGRectGetWidth(self.view.frame)-40, 2)];
    
//    lineDotV.backgroundColor = [UIColor redColor];
//    lineDotV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dot1.jpg"]];

    lineDotV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line_addr"]];
    
    
    [self.view addSubview:lineDotV];
    
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
