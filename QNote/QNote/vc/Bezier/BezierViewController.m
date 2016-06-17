//
//  BezierViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/9.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BezierViewController.h"
#import <Masonry.h>

@interface BezierViewController ()

@end

/**
 *  参考
 *  http://www.jianshu.com/p/999ad5ae6edf
 *  http://www.jianshu.com/p/281373b6d1a8
 
 *  
 *  drawrect之后背景色是黑色的 不能修改 
 *  http://blog.csdn.net/xyzdm123/article/details/46891001
 */

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     
     [[UIColor blackColor] setStroke];　　　　// 设置边框颜色
     [[UIColor blueColor] setFill];　　　　　　// 设置背景填充色
     [[UIColor greenColor] set];　　　　　　　　// 设置字符颜色
     
     */
    
    
    
    
    
    
    
    __block UIScrollView * scrollV = [[UIScrollView alloc] init];
    [self.view addSubview:scrollV];
    
    
    NSArray * list = @[
                       @{@"title":@"一阶曲线",@"class":@"BezierLineV"},
                       @{@"title":@"二三阶曲线",@"class":@"BezierCurveV"},
                       @{@"title":@"矩形",@"class":@"BezierRect"},
                       @{@"title":@"圆弧",@"class":@"BezierArc"},
                       @{@"title":@"三角",@"class":@"BezierTriangle"},
                       
                       @{@"title":@"聊天泡泡",@"class":@"BezierChatPopV"},
  
                   @{@"title":@"CAKeyFrameAnimation",@"class":@"BeizerFrameAnimationV"}
                       
                       
                       
                       ];
   
    NSMutableArray * bezierViews = [[NSMutableArray alloc] init];
    
//    for(NSDictionary * dataDic in [list reverseObjectEnumerator])
    for(NSDictionary * dataDic in list)
    {
        UIView * subV = [self bezierElementViewWithDic:dataDic];
        [scrollV addSubview:subV];
        subV.backgroundColor = [UIColor grayColor];
        [bezierViews addObject:subV];
    }
    
    __weak typeof(&*self)weakSelf = self;
    
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [bezierViews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    
    [bezierViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(300);
    }];
    
}


- (UIView *)bezierElementViewWithDic:(NSDictionary *)dataDic
{
    __block UIView * contentV = [UIView new];
    contentV.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05];
    
    NSString * title = dataDic[@"title"];
    NSString * classStr = dataDic[@"class"];
    
    
    __block UILabel * lab = [[UILabel alloc] init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor lightGrayColor];
    lab.text = title;
    [contentV addSubview:lab];
    
    
    UIView * bezierV = [NSClassFromString(classStr) new];
    [contentV addSubview:bezierV];

    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentV);
        make.height.mas_equalTo(20);
    }];
    
    [bezierV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom);
        make.left.right.bottom.equalTo(contentV);
    }];
    
    
    return contentV;
}



- (UIColor *)colorRandom
{
    CGFloat red = random()/RAND_MAX;
    CGFloat green = random()/RAND_MAX;
    CGFloat blue = random()/RAND_MAX;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
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
