//
//  HTMLWebViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/23.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "HTMLWebViewController.h"

/**
 *  参考
 *  http://www.jianshu.com/p/ee417ad66ad4
 */

@interface HTMLWebViewController ()

@end

@implementation HTMLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView * webV = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webV.autoresizingMask = 0xff;
    [self.view addSubview:webV];
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:@"useHTML"];
    [webV loadRequest:[NSURLRequest requestWithURL:url]];
    
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
