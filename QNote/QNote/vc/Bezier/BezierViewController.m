//
//  BezierViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/9.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BezierViewController.h"

@interface BezierViewController ()

@end

/**
 *  参考
 *  http://www.jianshu.com/p/999ad5ae6edf
 */

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    UIBezierPath
    [self drawTrianglePath];
}

- (void)drawTrianglePath {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(self.view.frame.size.width - 40, 20)];
    [path addLineToPoint:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 20)];
    
    // 最后的闭合线是可以通过调用closePath方法来自动生成的，也可以调用-addLineToPoint:方法来添加
    //  [path addLineToPoint:CGPointMake(20, 20)];
    
    [path closePath];
    
    // 设置线宽
    path.lineWidth = 1.5;
    
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    
    // 根据我们设置的各个点连线
    [path stroke];
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
