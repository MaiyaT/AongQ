//
//  CoreGraphicsExampleVC.m
//  QNote
//
//  Created by 林宁宁 on 16/7/8.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "CoreGraphicsExampleVC.h"
#import <Masonry.h>



@interface CoreGraphicsExampleVC ()

@end

@implementation CoreGraphicsExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.'
    
    
    
    __block UIScrollView * scrollV = [[UIScrollView alloc] init];
    [self.view addSubview:scrollV];
    
    
    NSArray * list = @[
                       @{@"title":@"简单绘图",@"class":@"GraphicsSimple"},
                       @{@"title":@"简单绘图",@"class":@"GraphicsSimple"}
                       
                       ];
    
    NSMutableArray * drawViews = [[NSMutableArray alloc] init];
    
    for(NSDictionary * dataDic in [list reverseObjectEnumerator])
//    for(NSDictionary * dataDic in list)
    {
        UIView * subV = [self graphicsElementViewWithDic:dataDic];
        [scrollV addSubview:subV];
        subV.backgroundColor = [UIColor grayColor];
        [drawViews addObject:subV];
    }
    
    __weak typeof(&*self)weakSelf = self;
    
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [drawViews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    
    [drawViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(300);
    }];

}



- (UIView *)graphicsElementViewWithDic:(NSDictionary *)dataDic
{
    __block UIView * contentV = [UIView new];
    contentV.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05];
    
    NSString * title = dataDic[@"title"];
    NSString * classStr = dataDic[@"class"];
    NSString * method = dataDic[@"method"];
    
    __block UILabel * lab = [[UILabel alloc] init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor lightGrayColor];
    lab.text = title;
    [contentV addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentV);
        make.height.mas_equalTo(20);
    }];
    
    if(classStr)
    {
        UIView * bezierV = [NSClassFromString(classStr) new];
        [contentV addSubview:bezierV];
        
        [bezierV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lab.mas_bottom);
            make.left.right.bottom.equalTo(contentV);
        }];
    }
    else if (method)
    {
        SEL methodSEL = NSSelectorFromString(method);
        if([self respondsToSelector:methodSEL])
        {
            [self performSelectorOnMainThread:methodSEL withObject:contentV waitUntilDone:YES];
        }
    }
    
    return contentV;
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
