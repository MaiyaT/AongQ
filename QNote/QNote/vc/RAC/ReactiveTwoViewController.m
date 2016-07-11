//
//  ReactiveTwoViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/7/7.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "ReactiveTwoViewController.h"

@interface ReactiveTwoViewController ()

@end

@implementation ReactiveTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    loginBtn.frame = CGRectMake(50, 220, CGRectGetWidth(self.view.frame)-100, 40);
    [loginBtn setTitle:@"发消息" forState:UIControlStateNormal];
    
    loginBtn.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:loginBtn];
    
    [[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        if(self.passSignalDelegate)
        {
            [self.passSignalDelegate sendNext:@"哈哈哈"];
        }
        
    }];
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
