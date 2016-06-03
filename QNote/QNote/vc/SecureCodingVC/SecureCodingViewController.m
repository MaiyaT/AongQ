//
//  SecureCodingViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/2.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "SecureCodingViewController.h"
#import "SecureObj.h"


@interface SecureCodingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation SecureCodingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    SecureObj * obj1 = [[SecureObj alloc] init];
    obj1.dataList = [[NSMutableArray alloc] initWithObjects:@"asd",@"bsd",@"1423", nil];
    obj1.secureIndex = 2;
    obj1.secureTitle = @"tessttt";

    SecureObj *obj2 = [[SecureObj alloc] init];
    obj2.dataList = [[NSMutableArray alloc] initWithObjects:@"asd",@"bsd",@"1423", nil];
    obj2.secureIndex = 2;
    obj2.secureTitle = @"tessttt";
    obj2.superObj = obj1;
    obj2.secureContent = @"sadasdasdasdasdsad";
    
    [obj2 getPropertyNames];
    
    
//    NSKeyedUnarchiver
//    [obj2 ]
    
    /*
     NSCoder是一个抽象类,我们不会直接使用它来创建对象. 相反,我们会使用从它继承来的子类. 也就是我们使用 NSKeyedUnarchiver类来从字节流中读取数据,而使用NSKeyedArchiver类来把对象写入到字节流
     */
    
    
}
- (IBAction)btnEventArchive:(id)sender {
    
    SecureObj * obj = [SecureObj new];
    obj.secureTitle = self.titleField.text;
    obj.secureContent = self.contentTextView.text;
    
    [NSKeyedArchiver archiveRootObject:obj toFile:[self pathArchive]];
    
}
- (IBAction)btnEventUnArchive:(id)sender {
    
    SecureObj * obj = [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathArchive]];
    
    self.titleField.text = obj.secureTitle;
    self.contentTextView.text = obj.secureContent;
    
}
- (IBAction)btnEventRightNavcBar:(id)sender {
    
    [self.view endEditing:YES];
}

- (NSString *)pathArchive
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    path = [path stringByAppendingPathComponent:@"archive"];
    
    NSLog(@"###### %@",path);
    
    return path;
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
