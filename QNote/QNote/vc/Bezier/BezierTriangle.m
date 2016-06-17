//
//  BezierTriangle.m
//  QNote
//
//  Created by 林宁宁 on 16/6/16.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "BezierTriangle.h"

@implementation BezierTriangle

-(void)drawRect:(CGRect)rect
{
    
    //三角形
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(20, 20)];
    
    [path1 addLineToPoint:CGPointMake(220, 20)];
    [path1 addLineToPoint:CGPointMake(110, 200)];
    
    //这两个都行
//    [path1 addLineToPoint:CGPointMake(20, 20)];
    [path1 closePath];
    
    path1.lineWidth = 5;
    
    [[UIColor blueColor] set];
    [path1 fill];
    
    [[UIColor greenColor] setStroke];
    [path1 stroke];
}

@end
