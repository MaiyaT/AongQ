//
//  BezierRect.m
//  QNote
//
//  Created by 林宁宁 on 16/6/16.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BezierRect.h"

@implementation BezierRect

-(void)drawRect:(CGRect)rect
{
    [[UIColor lightGrayColor] setFill];
    UIRectFill(rect);
    
    //直角矩形
    UIBezierPath * path1 = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 100, 100)];
    path1.lineWidth = 5;
    [[UIColor redColor] setStroke];
    [path1 stroke];
    
    
    //圆角矩形
    UIBezierPath * path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(120, 10, 100, 100) cornerRadius:30];
    path2.lineWidth = 5;
    [[UIColor blueColor] setFill];
    [path2 fill];
    
    
    //这个设置圆角 没用....
    UIBezierPath * path3 = [UIBezierPath bezierPathWithRect:CGRectMake(230, 10, 100, 100)];
    path3.lineWidth = 5;
    path3.lineJoinStyle = kCGLineJoinRound;
    path3.lineCapStyle = kCGLineCapRound;
    [[UIColor greenColor] setStroke];
    [path3 stroke];
    
    
    //部分圆角矩形  最后一个参数 水平和垂直方向的半径的大小。。。
    UIBezierPath * path4 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 140, 300, 100) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(50, 20)];
    
    path4.lineWidth = 5;
    [[UIColor orangeColor] setStroke];
    [path4 stroke];
}

@end
