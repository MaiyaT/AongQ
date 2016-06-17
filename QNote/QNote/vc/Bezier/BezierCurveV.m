//
//  BezierCurveV.m
//  QNote
//
//  Created by 林宁宁 on 16/6/16.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BezierCurveV.h"

@implementation BezierCurveV

-(void)drawRect:(CGRect)rect
{
    [[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] setFill];
    UIRectFill(rect);
    
    //二阶曲线
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 5;
    
    //起点
    [path1 moveToPoint:CGPointMake(20, 20)];
    
    //第一个 终点 第二个 控制点
    [path1 addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(400, 20)];
    
    [[UIColor redColor] setStroke];
    
    [path1 stroke];
    
    
    //三阶曲线
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    path2.lineWidth = 5;
    [path2 moveToPoint:CGPointMake(20, 200)];
    
    [path2 addCurveToPoint:CGPointMake(300, 20) controlPoint1:CGPointMake(100, -80) controlPoint2:CGPointMake(200, 200)];
    
    [[UIColor blueColor] setStroke];
    
    [path2 stroke];
}

@end
